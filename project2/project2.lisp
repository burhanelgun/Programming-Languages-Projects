; DIRECTIVE identify
;Note: I did "; DIRECTIVE identify" part for grading. You can use sample tests which are at the end of this page for grading. But also just in case I did "; DIRECTIVE: print" part too.


(defun whichIF (tokenList)   ;for choosing the (if EXPB EXPLISTI EXPLISTI) OR (if EXPB EXPLISTI) return 1
		(cond ((not(eq (list-length tokenList) 0))
				(cond   ((string-equal (car(cdr(car tokenList))) ")") 
							(cond   ((or
										(and (string-equal (car(car(cdr tokenList))) "identifier") (string-equal (car(car(cdr(cdr tokenList)))) "identifier")) ;(if EXPB EXPLISTI EXPLISTI) return 2
										(and (string-equal (car(car(cdr tokenList))) "identifier") (string-equal (car(cdr(car(cdr(cdr tokenList))))) "("))
							 			(and (string-equal (car(car(cdr tokenList))) "integer") (string-equal (car(cdr(car(cdr(cdr tokenList))))) "(") )
							 			(and (string-equal (car(car(cdr tokenList))) "integer") (string-equal (car(car(cdr(cdr tokenList)))) "integer"))

							 			(and (string-equal (car(cdr(car(cdr tokenList)))) "(") 
							 				(or (string-equal (car(car(cdr(cdr tokenList)))) "keyword") (string-equal (car(cdr(car(cdr (cdr tokenList))))) "+") (string-equal (car(cdr(car(cdr(cdr tokenList))))) "-") (string-equal (car(cdr(car(cdr(cdr tokenList))))) "*") (string-equal (car(cdr(car(cdr (cdr tokenList))))) "/")  ) 
							 				(or (string-equal (car(car(cdr (cdr(cdr tokenList))))) "identifier") (string-equal (car(car(cdr (cdr(cdr tokenList))))) "integer")) 
							 				(or (string-equal (car(car(cdr(cdr (cdr (cdr tokenList)))))) "identifier") (string-equal (car(car(cdr(cdr (cdr (cdr tokenList)))))) "integer") ) (string-equal (car(cdr(car(cdr(cdr(cdr (cdr (cdr tokenList)))))))) ")")  (string-equal (car(cdr(car(cdr(cdr(cdr(cdr(cdr(cdr tokenList ))))))))) "("))
							 			(and (string-equal (car(cdr(car(cdr tokenList)))) "(") 
							 				(or (string-equal (car(car(cdr(cdr tokenList)))) "keyword") (string-equal (car(cdr(car(cdr (cdr tokenList))))) "+") (string-equal (car(cdr(car(cdr(cdr tokenList))))) "-") (string-equal (car(cdr(car(cdr(cdr tokenList))))) "*") (string-equal (car(cdr(car(cdr (cdr tokenList))))) "/")  ) 
							 				(or (string-equal (car(car(cdr (cdr(cdr tokenList))))) "identifier") (string-equal (car(car(cdr (cdr(cdr tokenList))))) "integer")) 
							 				(or (string-equal (car(car(cdr(cdr (cdr (cdr tokenList)))))) "identifier") (string-equal (car(car(cdr(cdr (cdr (cdr tokenList)))))) "integer") )  (string-equal (car(cdr(car(cdr(cdr(cdr (cdr (cdr tokenList)))))))) ")")  (string-equal (car(car(cdr(cdr(cdr(cdr (cdr (cdr tokenList)))))))) "identifier"))
										(and (string-equal (car(cdr(car(cdr tokenList)))) "(") 
											(or (string-equal (car(car(cdr(cdr tokenList)))) "keyword") (string-equal (car(cdr(car(cdr (cdr tokenList))))) "+") (string-equal (car(cdr(car(cdr(cdr tokenList))))) "-") (string-equal (car(cdr(car(cdr(cdr tokenList))))) "*") (string-equal (car(cdr(car(cdr (cdr tokenList))))) "/")  ) 
											(or (string-equal (car(car(cdr (cdr(cdr tokenList))))) "identifier") (string-equal (car(car(cdr (cdr(cdr tokenList))))) "integer")) 
											(or (string-equal (car(car(cdr(cdr (cdr (cdr tokenList)))))) "identifier") (string-equal (car(car(cdr(cdr (cdr (cdr tokenList)))))) "integer") )  (string-equal (car(cdr(car(cdr(cdr(cdr (cdr (cdr tokenList)))))))) ")")  (string-equal (car(car(cdr(cdr(cdr(cdr (cdr (cdr tokenList)))))))) "integer"))
								    )
										2
									) 
									( ;(if EXPB EXPLISTI) return 1
										1
									)
							)
						) 
						(
					 		 (whichIF (cdr tokenList)) ;recursive call
						)
				)
			 ) 
	    )

)

(defun printTokens(tokenList)
	(cond   ((eq (list-length tokenList) 0)) ;continue the recursive call until the list is empty
			(
			   (with-open-file (str "151044060.tree" :direction :output :if-exists :append :if-does-not-exist :create)  ;opening a file
				  (format str "(\"")
				  (format str (car(car tokenList)))   ;token class
				  (format str "\" ")
				  (format str "\"")
				  (format str (car(cdr(car tokenList))))  ;token
				  (format str "\")")
				  (terpri str)
				  (close str)
				  (printTokens (cdr tokenList))   ;recursive call
				)
			)

	)
)

; DIRECTIVE identify
(defun parser(tokenList) ;takes tokenList and identify the expression

	(with-open-file (str "151044060.tree" :direction :output :if-exists :supersede :if-does-not-exist :create) ;opening file and write static things
		(format str "; DIRECTIVE identify")
	    (terpri str)
	  	(format str "START -> INPUT")
	    (terpri str)
	    (format str "INPUT -> EXPI | EXPLISTI")
	    (terpri str)
	    (format str "EXPI -> ")


		(cond 																;determining the expression
			  ((string-equal (car (cdr (car (cdr tokenList)))) "set") 
			     (format str "(set ID EXPI)")
			  )
			  ((string-equal (car (cdr (car (cdr tokenList)))) "+")
			     (format str "(+ EXPI EXPI)")
			  )
			  ((string-equal (car (cdr (car (cdr tokenList)))) "-")
			     (format str "(- EXPI EXPI)")
			  )
			  ((string-equal (car (cdr (car (cdr tokenList)))) "*")
			     (format str "(* EXPI EXPI)")
			  )
			  ((string-equal (car (cdr (car (cdr tokenList)))) "/")
			     (format str "(/ EXPI EXPI)")
			  )
			  ((string-equal (car(car (cdr tokenList))) "identifier")
			     (format str "ID | (ID EXPLISTI) | VALUES")
			  )
			  ((string-equal (car (cdr (car (cdr tokenList)))) "deffun")
			     (format str "(deffun ID IDLIST EXPLISTI)")
			  )
			  ((string-equal (car (cdr (car (cdr tokenList)))) "defvar")
			     (format str "(defvar ID EXPI)")
			  )
			  ((string-equal (car (cdr (car (cdr tokenList)))) "set")
			     (format str "(set ID EXPI)")
			  )
			  ((string-equal (car (cdr (car (cdr tokenList)))) "if")
			  		(cond   ((eq (whichIF tokenList) 1)
								(format str "(if EXPB EXPLISTI)")
							) 
							(
						 		 (format str "(if EXPB EXPLISTI EXPLISTI)")
							)
					)
			  )
			  ((string-equal (car (cdr (car (cdr tokenList)))) "while")
			     (format str "(while (EXPB) EXPLISTI)") 
			  )
			  ((string-equal (car (cdr (car (cdr tokenList)))) "for")
			     (format str "(for (ID EXPI EXPI) EXPLISTI)")			     
			  )

		)
		(close str)  ; closing file

	)

)



;SAMPLE TESTS for ; DIRECTIVE identify

;sample test 1
;(parser '(("operator" "(") ("keyword" "deffun") ("operator" "(") ("identifier" "x") ("operator" ")") ("identifier" "y") ("operator" ")")))   ;(deffun (x) y)

;sample test 2
(parser '(("operator" "(") ("operator" "+") ("integer" "1") ("integer" "2") ("operator" ")")))  ;(+ 1 2)

;sample test 3
;(parser '(("operator" "(") ("keyword" "if") ("operator" "(") ("identifier" "t") ("operator" ")") ("identifier" "a") ("identifier" "b") ("operator" ")")));(if (t) a b)
