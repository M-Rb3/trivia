import os
from flask import Flask, request, abort, jsonify
from flask.helpers import send_from_directory
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
import random

from models import setup_db, Question, Category

QUESTIONS_PER_PAGE = 10

# adding pagination to the question


def paginate_question(request, selection):
    page = request.args.get("page", 1, type=int)
    start = (page - 1) * QUESTIONS_PER_PAGE
    end = start + QUESTIONS_PER_PAGE

    question = [question.format() for question in selection]
    current_questions = question[start:end]
    return current_questions


def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, static_folder="../frontend/build")
    setup_db(app)
    # set up CORS allowing all the origins
    cors = CORS(app, resources={"/": {"origins": "*"}})

    @app.after_request
    def after_request(response):
        response.headers.add(
            "Access-Control-Allow-Headers", "Content-Type,Authorization,true"
        )
        response.headers.add(
            "Access-Control-Allow-Methods", "GET,PUT,POST,DELETE,OPTIONS"
        )
        return response

    @app.route("/")
    def serve():
        return send_from_directory(app.static_folder, "index.html")

    @app.route("/categories")
    def retrieve_categories():
        categories = Category.query.order_by(Category.id).all()
        categories_dic = {}
        # get all categories and add to dictionary
        for category in categories:
            categories_dic[category.id] = category.type
        # abort 404 if no categories is found
        if len(categories_dic) == 0:
            abort(404)
        # return data as json to the view
        return jsonify(
            {
                "success": True,
                "categories": categories_dic,
                "total_categories": len(categories_dic),
            }
        )

    @app.route("/questions")
    def retrieve_questions():
        # get all questions and paginate them
        selection = Question.query.order_by(Question.id).all()
        current_questions = paginate_question(request, selection)

        # get all categories and add to dictionary
        categories = Category.query.order_by(Category.id).all()
        categories_dic = {}
        for category in categories:
            categories_dic[category.id] = category.type

        # abort 404 if no questions is found
        if len(current_questions) == 0:
            abort(404)

        return jsonify(
            {
                "success": True,
                "questions": current_questions,
                "total_questions": len(selection),
                "categories": categories_dic,
            }
        )

    @app.route("/questions/<int:question_id>", methods=["DELETE"])
    def delete_question(question_id):
        try:
            # get the question using the id
            question = Question.query.filter(
                Question.id == question_id).one_or_none()

            # abort 404 if no question is found
            if question is None:
                abort(404)

            # delete the question
            question.delete()
            selection = Question.query.order_by(Question.id).all()
            current_questions = paginate_question(request, selection)
            # return success response upon deleting
            return jsonify(
                {
                    "success": True,
                    "deleted": question_id,
                    "questions": current_questions,
                    "total_questions": len(Question.query.all()),
                }
            )

        except:
            # abort if there is a problem while deleting the question
            abort(422)

    @app.route("/questions", methods=["POST"])
    def create_question():

        body = request.get_json()
        # if search term is provided
        if body.get("searchTerm"):

            search_term = body.get("searchTerm")
            # query the database using search term
            selection = Question.query.filter(
                Question.question.ilike(f"%{search_term}%")
            ).all()
            # abot 404 if no results is found
            if len(selection) == 0:
                abort(404)
            # paginate the results
            current_questions = paginate_question(request, selection)
            # return the results
            return jsonify(
                {
                    "success": True,
                    "questions": current_questions,
                    "total_questions": len(Question.query.all()),
                }
            )
        # if no search term is found. Create new question
        else:
            # get data from body request
            new_question = body.get("question")
            new_answer = body.get("answer")
            new_category = body.get("category")
            new_difficulty = body.get("difficulty")
            # ensure all fields have data ,so it does not abort200 even in the failer request
            if (
                (new_question is None)
                or (new_answer is None)
                or (new_difficulty is None)
                or (new_category is None)
            ):
                abort(422)

            try:
                # create and insert new question
                question = Question(
                    question=new_question,
                    answer=new_answer,
                    category=new_category,
                    difficulty=new_difficulty,
                )
                question.insert()
                # get all questions and paginate them
                selection = Question.query.order_by(Question.id).all()
                current_questions = paginate_question(request, selection)

                return jsonify(
                    {
                        "success": True,
                        "created": question.id,
                        "question_created": question.question,
                        "questions": current_questions,
                        "total_questions": len(Question.query.all()),
                    }
                )

            # abort unprocessable if an exception has been raised
            except:
                abort(422)

    @app.route("/categories/<int:category_id>/questions")
    def retrieve_questions_for_category(category_id):
        # get the category by id
        category = Category.query.filter_by(id=category_id).one_or_none()
        # abort bad request(400) if the category is not found
        if category is None:
            abort(400)

        # get the matching questions for the specfifed category.id
        selection = Question.query.filter_by(category=category.id).all()
        # paginate the results
        current_questions = paginate_question(request, selection)

        return jsonify(
            {
                "success": True,
                "questions": current_questions,
                "total_questions": len(Question.query.all()),
                "current_category": category.type,
            }
        )

    @app.route("/quizzes", methods=["POST"])
    def get_quiz():
        # load the request body
        body = request.get_json()

        # get the previous questions
        previous_questions = body.get("previous_questions")

        # get the category
        category = body.get("quiz_category")
        # abort bad request if category or previous questions is not found
        if (category is None) or (previous_questions is None):
            abort(400)

        # load all questions if (ALL) is selected
        if category["id"] == 0:
            questions = Question.query.all()
        # load questions for chosen category
        else:
            questions = Question.query.filter_by(category=category["id"]).all()

        # get the number for the total questions
        total = len(questions)

        # picks a random question
        def get_random_question():
            return questions[random.randrange(0, len(questions), 1)]

        # checks if the question has already been used
        def check_if_used(question):
            used = False
            for question in previous_questions:
                if question == question.id:
                    used = True

            return used

        # get random question
        question = get_random_question()

        # check if used until finding unused question
        while check_if_used(question):
            question = get_random_question()

            # if all questions have been tried
            if len(previous_questions) == total:
                return jsonify({"success": True})

        # return the question
        return jsonify({"success": True, "question": question.format()})

    # ERROR HNDLERS
    @app.errorhandler(404)
    def not_found(error):
        return (
            jsonify({"success": False, "error": 404,
                    "message": "resource not found"}),
            404,
        )

    @app.errorhandler(422)
    def unprocessable(error):
        return (
            jsonify({"success": False, "error": 422,
                    "message": "unprocessable"}),
            422,
        )

    @app.errorhandler(400)
    def bad_request(error):
        return jsonify({"success": False, "error": 400, "message": "bad request"}), 400

    return app
