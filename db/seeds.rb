CORRECT_VALUE = 1
WRONG_VALUE = 0

q1 = Question.create(content: "Is scaffold command self-contained package of Ruby on Rails code")
Answer.create( question_id: q1.id, 
				content: "Yes", 
				is_correct: CORRECT_VALUE)
Answer.create( question_id: q1.id, 
				content: "No", 
				is_correct: WRONG_VALUE)

q2 = Question.create(content: "Is it good to redirect after inserting info into the database?")
Answer.create( question_id: q2.id, 
				content: "Yes", 
				is_correct: CORRECT_VALUE)
Answer.create( question_id: q2.id, 
				content: "No", 
				is_correct: WRONG_VALUE)

q3 = Question.create(content: "Does rake know which migrations have been run and which have not?")
Answer.create( question_id: q3.id, 
				content: "Yes", 
				is_correct: CORRECT_VALUE)
Answer.create( question_id: q3.id, 
				content: "No", 
				is_correct: WRONG_VALUE)

q4 = Question.create(content: "What is the status code for 'success' when throwing a GET?")
Answer.create( question_id: q4.id, 
				content: "200", 
				is_correct: CORRECT_VALUE)
Answer.create( question_id: q4.id, 
				content: "400", 
				is_correct: WRONG_VALUE)
Answer.create( question_id: q4.id, 
				content: "500", 
				is_correct: WRONG_VALUE)
