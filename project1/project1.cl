(defvar KEYWORDS '("and" "or" "not" "equal" "append" "concat" "set" "deffun" "for" "while" "if" "exit")) ;keywordler
(defvar OPERATORS '("+" "-" "/" "*" "(" ")" "**")) ;operatorler

(setq tempList '())
(defvar tokenList '())



(defun lexer(fileName)

	(iterate-list (get-file-to-list fileName));dosya içeriği satır satır listeye koyulur ve liste dolaşılır.Dolaşılırkende tokenList doldurulur.

	tokenList

)

(defun add-to-end (number) ;tokenList listesinin sonuna ekleme yapan fonksiyon
	(cond ((eq tokenList NIL)
			(push number tokenList) ;eger tokenList listesi bossa tokenList listesine ilk elemani push ile ekleriz
		  )
	      (
		(push  number (cdr (last tokenList))) ; tokenList listesinin en sonuna ekleme yapar
	      )
	)
)
(defun add-to-end-entry (number) ;tempList listesinin sonuna ekleme yapan fonksiyon
	(cond ((eq tempList NIL)
			(push number tempList) ;eger tempList listesi bossa tempList listesine ilk elemani push ile ekleriz
		  )
	      (
		(push  number (cdr (last tempList))) ; tempList listesinin en sonuna ekleme yapar
	      )
	)
)

(defun make-one-entry (code val) ; code olarak OPERATORMU KEYWORDMU onu alır, val Olarak ise + mı - mi and mi or mu alır 
	(setq tempList '())			;sonra bu iki argumanı alır ve tempListin içine atar yani temp List iki stringden oluşan bir liste olur.	
	(add-to-end-entry code)     ;bu listeyi return eder
	(add-to-end-entry val)
	tempList

)

(defun get-file-to-list (fileName)  ;okunan dosyayı listeye atar ve listeyi return eder
  (with-open-file (buffer fileName);(string listesidir)(her bir satır bir stringtir)
    (loop for row = (read-line buffer nil)
          while row
          collect row)))

(defun iterate-list (lst)

	(cond ((= (list-length lst) 0))
		  (
		  (handle-string (substitute #\Space #\Tab (string-trim '(#\Tab) (car lst))))  (iterate-list (cdr lst))) ;listenin her bir satırını string olarak
	)															;handle-string methoduna yollar	;tab varsa onu boşluğa çevirir ilk baştaki tabıda siler
)

(defun handle-string(str)

(setq a 0)
(setq flag 0)
(setq b 1)
(setq counter 0)
(setq undefinedToken 0)
(cond ((> (length str) 0) ;gelen stringin sizeı 0 dan büyükse girer  


		  (loop ;string in içinde gezer baştan sona

			  (cond ((not(string-equal (find (subseq str a b) OPERATORS :test #'string=) NIL)) ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
			  					;negatif bir sayıysa(unary - için)
			  							(cond ((> (+ a 1) (- (length str) 1)) ;binary operator sondaysa
												(add-to-end (make-one-entry "operator" (subseq str a b)))
												
												(return counter)
												  )
										)
					  		  (cond ((and (string-equal (subseq str a b) "-") (or (string-equal (subseq str (+ a 1) (+ b 1) ) "1") (string-equal (subseq str (+ a 1) (+ b 1) ) "2") 
					  		  (string-equal (subseq str (+ a 1) (+ b 1) ) "3") (string-equal (subseq str (+ a 1) (+ b 1) ) "4") (string-equal (subseq str (+ a 1) (+ b 1) ) "5") 
					  		  (string-equal (subseq str (+ a 1) (+ b 1) ) "6") (string-equal (subseq str (+ a 1) (+ b 1) ) "7") (string-equal (subseq str (+ a 1) (+ b 1) ) "8") 
					  		  (string-equal (subseq str (+ a 1) (+ b 1) ) "9") ))  ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer	


									    (setq beginIndex a)
										(setq counter a)

										(loop 


										   (setq counter (+ counter 1))


											(cond ((> counter (length str))
												(return counter)
												  )
											)

										   (cond ((not(or (string-equal (subseq str (- counter 1) counter) "0") (string-equal (subseq str (- counter 1) counter) "1") (string-equal (subseq str (- counter 1) counter) "2") (string-equal (subseq str (- counter 1) counter) "3")
										   (string-equal (subseq str (- counter 1) counter) "4") (string-equal (subseq str (- counter 1) counter) "5") (string-equal (subseq str (- counter 1) counter) "6") (string-equal (subseq str (- counter 1) counter) "7") (string-equal (subseq str (- counter 1) counter) "8")
										   (string-equal (subseq str (- counter 1) counter) "9") (string-equal (subseq str (- counter 1) counter) "-")))
														(return counter);hata durumu
														  )
													)

										   (when (or (string-equal (subseq str (- counter 1) counter) ")") (string-equal (subseq str (- counter 1) counter) "(")
										   (string-equal (subseq str (- counter 1) counter) "/") 
										   (string-equal (subseq str (- counter 1) counter) "*") (string-equal (subseq str (- counter 1) counter) "+") (string-equal (subseq str (- counter 1) counter) " ")) (return counter)) ;ya en sondaysa? boşluk bulamaz hiç
										)	

										;negatifse
											 
										(add-to-end (make-one-entry "integer" (subseq str beginIndex (- counter 1))))
										
										(setq a (+ a (- (- (- counter 1) beginIndex) 1)))
										(setq b (+ b (- (- (- counter 1) beginIndex) 1)))


					  		  		)
					  		  		;else
					  		  		(

					  		  				;** operatoru için
											(cond ((and (string-equal (subseq str a b) "*") (string-equal (subseq str (+ a 1) (+ b 1)) "*"))  ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer	
												
   												   (add-to-end (make-one-entry "operator" "**")) ; o 1 karakterlik string ile OPERAROTOR u bir liste haline getirmek için make-one-entry ye gönderilir.
								  				   
								  				   (setq a (+ a 1))
											   	   (setq b (+ b 1))
								  				   (setq flag 1)		
								  				   (setq negative 0)

								  		  		)
								  		  		;else diğer normal operatorler için
								  		  		(

												   (add-to-end (make-one-entry "operator" (subseq str a b))) ; o 1 karakterlik string ile OPERAROTOR u bir liste haline getirmek için make-one-entry ye gönderilir.
								  				   
								  				   (setq flag 1)		
								  				   (setq negative 0)

								  		  			)
								  		  	)

					  		  		)
					  		  )
											;sonra ordan dönen liste ana listemize eklenmek izere add-to-end fonksiyonuna gönderilir.
			  		  )
			  		  ;else
			  		  (


							  (cond ((not(string-equal (subseq str a b) " ")) ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
										(setq negative 0)
										(cond ((< (+ a 2) (length str))	
							  			(cond ((string-equal (subseq str a b) "a") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
									  		(cond ((string-equal (subseq str (+ a 1) (+ b 1)) "n") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer		
												(cond ((string-equal (subseq str (+ a 2) (+ b 2)) "d") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
													(cond ((> (- a 1) 0)

															(cond ((or (not(string-equal (find (subseq str (- a 1) (- b 1)) OPERATORS :test #'string=) NIL)) (string-equal (subseq str (- a 1) (- b 1)) " ") )
											   						(add-to-end (make-one-entry "keyword" "and"))
											   						
											   						(setq a (+ a 2))
											   						(setq b (+ b 2))
											   						(setq flag 1)
			  														  						
																  )
															)

														  )
															;else	
														  (
																(add-to-end (make-one-entry "keyword" "and"))	
																
																(setq a (+ a 2))
											   					(setq b (+ b 2))
																(setq flag 1)

														  )

													)	  			
										 ))))))))

										(cond ((< (+ a 2) (length str))
							  			(cond ((string-equal (subseq str a b) "n") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
									  		(cond ((string-equal (subseq str (+ a 1) (+ b 1)) "o") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer		
												(cond ((string-equal (subseq str (+ a 2) (+ b 2)) "t") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer			
													(cond ((> (- a 1) 0)

															(cond ((or (not(string-equal (find (subseq str (- a 1) (- b 1)) OPERATORS :test #'string=) NIL)) (string-equal (subseq str (- a 1) (- b 1)) " ") )
											   						(add-to-end (make-one-entry "keyword" "not"))
											   						
											   						(setq a (+ a 2))
											   						(setq b (+ b 2))
											   						(setq flag 1)
			  														  						
																  )
															)

														  )
															;else	
														  (
																(add-to-end (make-one-entry "keyword" "not"))
																
																(setq a (+ a 2))
											   					(setq b (+ b 2))
																(setq flag 1)
	
														  )

													)			  														  						
										 ))))))))

										(cond ((< (+ a 2) (length str))
							  			(cond ((string-equal (subseq str a b) "s") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
									  		(cond ((string-equal (subseq str (+ a 1) (+ b 1)) "e") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer		
												(cond ((string-equal (subseq str (+ a 2) (+ b 2)) "t") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
														  			
													(cond ((> (- a 1) 0)

															(cond ((or (not(string-equal (find (subseq str (- a 1) (- b 1)) OPERATORS :test #'string=) NIL)) (string-equal (subseq str (- a 1) (- b 1)) " ") )
											   						(add-to-end (make-one-entry "keyword" "set"))
																	
																	(setq a (+ a 2))
											   						(setq b (+ b 2))											   						
											   						(setq flag 1)
			  														  						
																  )
															)

														  )
															;else	
														  (
																(add-to-end (make-one-entry "keyword" "set"))	
																
																(setq a (+ a 2))
											   					(setq b (+ b 2))
																(setq flag 1)

														  )

													)		  														  						
										 ))))))))
															  	
										(cond ((< (+ a 2) (length str))
							  			(cond ((string-equal (subseq str a b) "f") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
									  		(cond ((string-equal (subseq str (+ a 1) (+ b 1)) "o") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer		
												(cond ((string-equal (subseq str (+ a 2) (+ b 2)) "r") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
														  			
													(cond ((> (- a 1) 0)

															(cond ((or (not(string-equal (find (subseq str (- a 1) (- b 1)) OPERATORS :test #'string=) NIL)) (string-equal (subseq str (- a 1) (- b 1)) " ") )
											   						(add-to-end (make-one-entry "keyword" "for"))
																	
																	(setq a (+ a 2))
											   						(setq b (+ b 2))											   						
											   						(setq flag 1)
			  														  						
																  )
															)

														  )
															;else	
														  (
																(add-to-end (make-one-entry "keyword" "for"))	
																
																(setq a (+ a 2))
											   					(setq b (+ b 2))															
																(setq flag 1)

														  )

													)			  														  						
										 ))))))))

										(cond ((< (+ a 1) (length str))
								  		(cond ((string-equal (subseq str a b) "o") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer		
											(cond ((string-equal (subseq str (+ a 1) (+ b 1)) "r") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
													  			
													(cond ((> (- a 1) 0)

															(cond ((or (not(string-equal (find (subseq str (- a 1) (- b 1)) OPERATORS :test #'string=) NIL)) (string-equal (subseq str (- a 1) (- b 1)) " ") )
											   						(add-to-end (make-one-entry "keyword" "or"))	
											   						
											   						(setq a (+ a 1))
											   						(setq b (+ b 1))
											   						(setq flag 1)
		  														  						
																  )
															)

														  )
															;else	
														  (
																(add-to-end (make-one-entry "keyword" "or"))
																
																(setq a (+ a 1))
											   					(setq b (+ b 1))
																(setq flag 1)
	
														  )

													)			  														  						
									 	))))))


										(cond ((< (+ a 1) (length str))
								  		(cond ((string-equal (subseq str a b) "i") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer		
											(cond ((string-equal (subseq str (+ a 1) (+ b 1)) "f") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
													  			
													(cond ((> (- a 1) 0)

															(cond ((or (not(string-equal (find (subseq str (- a 1) (- b 1)) OPERATORS :test #'string=) NIL)) (string-equal (subseq str (- a 1) (- b 1)) " ") )
											   						(add-to-end (make-one-entry "keyword" "if"))
											   						
											   						(setq a (+ a 1))
											   					(setq b (+ b 1))
											   						(setq flag 1)
			  														  						
																  )
															)

														  )
															;else	
														  (
																(add-to-end (make-one-entry "keyword" "if"))
																
																(setq a (+ a 1))
											   					(setq b (+ b 1))
																(setq flag 1)
	
														  )

													)			  														  						
									 	))))))

										(cond ((< (+ a 4) (length str))
										(cond ((string-equal (subseq str a b) "e") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
									  		(cond ((string-equal (subseq str (+ a 1) (+ b 1)) "q") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer		
												(cond ((string-equal (subseq str (+ a 2) (+ b 2)) "u") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
													(cond ((string-equal (subseq str (+ a 3) (+ b 3)) "a") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
														(cond ((string-equal (subseq str (+ a 4) (+ b 4)) "l") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer

													(cond ((> (- a 1) 0)

															(cond ((or (not(string-equal (find (subseq str (- a 1) (- b 1)) OPERATORS :test #'string=) NIL)) (string-equal (subseq str (- a 1) (- b 1)) " ") )
											   						(add-to-end (make-one-entry "keyword" "equal"))	
											   						
											   						(setq a (+ a 4))
											   					(setq b (+ b 4))
											   						(setq flag 1)
		  														  						
																  )
															)

														  )
															;else	
														  (
																(add-to-end (make-one-entry "keyword" "equal"))	
																
																(setq a (+ a 4))
											   					(setq b (+ b 4))
																(setq flag 1)

														  )

													)			  														  						
										 ))))))))))))

										(cond ((< (+ a 4) (length str))
										(cond ((string-equal (subseq str a b) "w") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
									  		(cond ((string-equal (subseq str (+ a 1) (+ b 1)) "h") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer		
												(cond ((string-equal (subseq str (+ a 2) (+ b 2)) "i") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
													(cond ((string-equal (subseq str (+ a 3) (+ b 3)) "l") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
														(cond ((string-equal (subseq str (+ a 4) (+ b 4)) "e") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer

													(cond ((> (- a 1) 0)

															(cond ((or (not(string-equal (find (subseq str (- a 1) (- b 1)) OPERATORS :test #'string=) NIL)) (string-equal (subseq str (- a 1) (- b 1)) " ") )
											   						(add-to-end (make-one-entry "keyword" "while"))	
											   						
											   						(setq a (+ a 4))
											   					(setq b (+ b 4))
											   						(setq flag 1)
		  														  						
																  )
															)

														  )
															;else	
														  (
																(add-to-end (make-one-entry "keyword" "while"))	
																
																(setq a (+ a 4))
											   					(setq b (+ b 4))
																(setq flag 1)

														  )

													)			  														  						
										 ))))))))))))

										(cond ((< (+ a 3) (length str))
							  			(cond ((string-equal (subseq str a b) "e") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
									  		(cond ((string-equal (subseq str (+ a 1) (+ b 1)) "x") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer		
												(cond ((string-equal (subseq str (+ a 2) (+ b 2)) "i") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
													(cond ((string-equal (subseq str (+ a 3) (+ b 3)) "t") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
														  			
													(cond ((> (- a 1) 0)

															(cond ((or (not(string-equal (find (subseq str (- a 1) (- b 1)) OPERATORS :test #'string=) NIL)) (string-equal (subseq str (- a 1) (- b 1)) " ") )
											   						(add-to-end (make-one-entry "keyword" "exit"))
											   						
											   						(setq a (+ a 3))
											   					(setq b (+ b 3))	
											   						(setq flag 1)
		  														  						
																  )
															)

														  )
															;else	
														  (
																(add-to-end (make-one-entry "keyword" "exit"))
																
																(setq a (+ a 3))
											   					(setq b (+ b 3))	
																(setq flag 1)

														  )

													)			  														  						
										 ))))))))))


										(cond ((< (+ a 3) (length str))
							  			(cond ((string-equal (subseq str a b) "t") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
									  		(cond ((string-equal (subseq str (+ a 1) (+ b 1)) "r") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer		
												(cond ((string-equal (subseq str (+ a 2) (+ b 2)) "u") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
													(cond ((string-equal (subseq str (+ a 3) (+ b 3)) "e") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
														  			
													(cond ((> (- a 1) 0)
															;dosya başında değilse (- a 1) uygulanabilir
															(cond ((or (not(string-equal (find (subseq str (- a 1) (- b 1)) OPERATORS :test #'string=) NIL)) (string-equal (subseq str (- a 1) (- b 1)) " ") )
											   						(add-to-end (make-one-entry "BinaryValue" "true"))
											   						
											   						(setq a (+ a 3))
											   					(setq b (+ b 3))	
											   						(setq flag 1)
		  														  						
																  )
															)

														  )
															;else dosya başındaysa
														  (
																(add-to-end (make-one-entry "BinaryValue" "true"))
																
																(setq a (+ a 3))
											   					(setq b (+ b 3))	
																(setq flag 1)

														  )

													)			  														  						
										 ))))))))))

										(cond ((< (+ a 4) (length str))
										(cond ((string-equal (subseq str a b) "f") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
									  		(cond ((string-equal (subseq str (+ a 1) (+ b 1)) "a") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer		
												(cond ((string-equal (subseq str (+ a 2) (+ b 2)) "l") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
													(cond ((string-equal (subseq str (+ a 3) (+ b 3)) "s") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
														(cond ((string-equal (subseq str (+ a 4) (+ b 4)) "e") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer

													(cond ((> (- a 1) 0)

															(cond ((or (not(string-equal (find (subseq str (- a 1) (- b 1)) OPERATORS :test #'string=) NIL)) (string-equal (subseq str (- a 1) (- b 1)) " ") )
											   						(add-to-end (make-one-entry "BinaryValue" "false"))	
											   						
											   						(setq a (+ a 4))
											   					(setq b (+ b 4))
											   						(setq flag 1)
		  														  						
																  )
															)

														  )
															;else	
														  (
																(add-to-end (make-one-entry "BinaryValue" "false"))	
																
																(setq a (+ a 4))
											   					(setq b (+ b 4))
																(setq flag 1)

														  )

													)			  														  						
										 ))))))))))))
										

										(cond ((< (+ a 5) (length str))
										(cond ((string-equal (subseq str a b) "d") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
									  		(cond ((string-equal (subseq str (+ a 1) (+ b 1)) "e") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer		
												(cond ((string-equal (subseq str (+ a 2) (+ b 2)) "f") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
													(cond ((string-equal (subseq str (+ a 3) (+ b 3)) "f") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
														(cond ((string-equal (subseq str (+ a 4) (+ b 4)) "u") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
															(cond ((string-equal (subseq str (+ a 5) (+ b 5)) "n") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
													(cond ((> (- a 1) 0)

															(cond ((or (not(string-equal (find (subseq str (- a 1) (- b 1)) OPERATORS :test #'string=) NIL)) (string-equal (subseq str (- a 1) (- b 1)) " ") )
											   						(add-to-end (make-one-entry "keyword" "deffun"))
											   						
											   						(setq a (+ a 5))
											   					(setq b (+ b 5))
											   						(setq flag 1)
			  														  						
																  )
															)

														  )
															;else	
														  (
																(add-to-end (make-one-entry "keyword" "deffun"))
																
																(setq a (+ a 5))
											   					(setq b (+ b 5))	
																(setq flag 1)

														  )

													)			  														  						
										 ))))))))))))))

										(cond ((< (+ a 5) (length str))
										(cond ((string-equal (subseq str a b) "a") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
									  		(cond ((string-equal (subseq str (+ a 1) (+ b 1)) "p") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer		
												(cond ((string-equal (subseq str (+ a 2) (+ b 2)) "p") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
													(cond ((string-equal (subseq str (+ a 3) (+ b 3)) "e") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
														(cond ((string-equal (subseq str (+ a 4) (+ b 4)) "n") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
															(cond ((string-equal (subseq str (+ a 5) (+ b 5)) "d") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
													(cond ((> (- a 1) 0)

															(cond ((or (not(string-equal (find (subseq str (- a 1) (- b 1)) OPERATORS :test #'string=) NIL)) (string-equal (subseq str (- a 1) (- b 1)) " ") )
											   						(add-to-end (make-one-entry "keyword" "append"))
											   						
											   						(setq a (+ a 5))
											   					(setq b (+ b 5))
											   						(setq flag 1)
			  														  						
																  )
															)

														  )
															;else	
														  (
																(add-to-end (make-one-entry "keyword" "append"))
																
																(setq a (+ a 5))
											   					(setq b (+ b 5))
																(setq flag 1)
	
														  )

													)			  														  						
										 ))))))))))))))												 									  	

										(cond ((< (+ a 5) (length str))
										(cond ((string-equal (subseq str a b) "c") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
									  		(cond ((string-equal (subseq str (+ a 1) (+ b 1)) "o") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer		
												(cond ((string-equal (subseq str (+ a 2) (+ b 2)) "n") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
													(cond ((string-equal (subseq str (+ a 3) (+ b 3)) "c") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
														(cond ((string-equal (subseq str (+ a 4) (+ b 4)) "a") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
															(cond ((string-equal (subseq str (+ a 5) (+ b 5)) "t") ; eger listenin 1 karakterlik string digiti OPERATORS listesinin içinde bulunuyorsa girer
													(cond ((> (- a 1) 0)

															(cond ((or (not(string-equal (find (subseq str (- a 1) (- b 1)) OPERATORS :test #'string=) NIL)) (string-equal (subseq str (- a 1) (- b 1)) " ") )
											   						(add-to-end (make-one-entry "keyword" "concat"))
											   						
											   						(setq a (+ a 5))
											   					(setq b (+ b 5))
											   						(setq flag 1)
			  														  						
																  )
															)

														  )
															;else	
														  (
																(add-to-end (make-one-entry "keyword" "concat"))	
																
																(setq a (+ a 5))
											   					(setq b (+ b 5))
																(setq flag 1)

														  )

													)			  														  						
										 ))))))))))))))		
										;sayı ile başlamayanları tespit etmek için(identifierdir sayı ile başlamıyorsa)
										(cond ((and (= flag 0) (not (string-equal (subseq str a b) "0")) (not (string-equal (subseq str a b) "1")) (not (string-equal (subseq str a b) "2")) (not (string-equal (subseq str a b) "3")) 
											(not (string-equal (subseq str a b) "4")) (not (string-equal (subseq str a b) "5")) (not (string-equal (subseq str a b) "6")) (not (string-equal (subseq str a b) "7")) (not (string-equal (subseq str a b) "8")) 
											(not (string-equal (subseq str a b) "9")))
										   (setq beginIndex a)
											(setq counter a)


											(loop 
											   (setq counter (+ counter 1))



											   (cond ((> counter (length str))
															(return counter)
															  )
														)

											   (cond ((or (string-equal (subseq str (- counter 1) counter) "0") (string-equal (subseq str (- counter 1) counter) "1") (string-equal (subseq str (- counter 1) counter) "2") (string-equal (subseq str (- counter 1) counter) "3")
											   (string-equal (subseq str (- counter 1) counter) "4") (string-equal (subseq str (- counter 1) counter) "5") (string-equal (subseq str (- counter 1) counter) "6") (string-equal (subseq str (- counter 1) counter) "7") (string-equal (subseq str (- counter 1) counter) "8")
											   (string-equal (subseq str (- counter 1) counter) "9"))
															(return counter);hata durumu
															  )
														)


											

											   (when (or (string-equal (subseq str (- counter 1) counter) ")") (string-equal (subseq str (- counter 1) counter) "(") 
											   (string-equal (subseq str (- counter 1) counter) "-") (string-equal (subseq str (- counter 1) counter) "/") 
											   (string-equal (subseq str (- counter 1) counter) "*") (string-equal (subseq str (- counter 1) counter) "+") (string-equal (subseq str (- counter 1) counter) " ")) (return counter)) ;ya en sondaysa? boşluk bulamaz hiç
											)																					;** sunada bak

													(cond ((not(string-equal (subseq str beginIndex (- counter 1)) " "))
															(add-to-end (make-one-entry "identifier" (subseq str beginIndex (- counter 1))))
																
																(setq a (+ a (- (- (- counter 1) beginIndex) 1)))
																(setq b (+ b (- (- (- counter 1) beginIndex) 1)))
															)
													)
																

													)

											;else
											;integer olma durumu(sayı ile başlıyorsa)
											(

												(cond ((= flag 0)
													   (setq beginIndex a)
														(setq counter a)


														(loop 
														   (setq counter (+ counter 1))



														   	;string rangeinin dışına çıkmasını önlemek için
															(cond ((> counter (length str))
																(return counter)
																  )
															)


														   (cond ((not(or (string-equal (subseq str (- counter 1) counter) "0") (string-equal (subseq str (- counter 1) counter) "1") (string-equal (subseq str (- counter 1) counter) "2") (string-equal (subseq str (- counter 1) counter) "3")
														   (string-equal (subseq str (- counter 1) counter) "4") (string-equal (subseq str (- counter 1) counter) "5") (string-equal (subseq str (- counter 1) counter) "6") (string-equal (subseq str (- counter 1) counter) "7") (string-equal (subseq str (- counter 1) counter) "8")
														   (string-equal (subseq str (- counter 1) counter) "9") ))
																		(return counter);hata durumu
																		  )
																	)


														   (when (or (string-equal (subseq str (- counter 1) counter) ")") (string-equal (subseq str (- counter 1) counter) "(") 
														   (string-equal (subseq str (- counter 1) counter) "-") (string-equal (subseq str (- counter 1) counter) "/") 
														   (string-equal (subseq str (- counter 1) counter) "*") (string-equal (subseq str (- counter 1) counter) "+") (string-equal (subseq str (- counter 1) counter) " ")) (return counter)) ;ya en sondaysa? boşluk bulamaz hiç
														)																					;** sunada bak




														(add-to-end (make-one-entry "integer" (subseq str beginIndex (- counter 1))))
														
														(setq a (+ a (- (- (- counter 1) beginIndex) 1)))
														(setq b (+ b (- (- (- counter 1) beginIndex) 1)))


														)
													)

												)
										)
							  		)	
					  		  )
			  		  )
			  	)


			(setq flag 0)


				;undefined kontrolü
   				(cond ((not(or 
					   (string-equal (subseq str a b) "a") (string-equal (subseq str a b) "b") (string-equal (subseq str a b) "c") 
					   (string-equal (subseq str a b) "d") (string-equal (subseq str a b) "e") (string-equal (subseq str a b) "f")
					   (string-equal (subseq str a b) "g") (string-equal (subseq str a b) "h") (string-equal (subseq str a b) "i")
					   (string-equal (subseq str a b) "j") (string-equal (subseq str a b) "k") (string-equal (subseq str a b) "l")
					   (string-equal (subseq str a b) "m") (string-equal (subseq str a b) "n") (string-equal (subseq str a b) "o")
					   (string-equal (subseq str a b) "p") (string-equal (subseq str a b) "q") (string-equal (subseq str a b) "r")
					   (string-equal (subseq str a b) "s") (string-equal (subseq str a b) "t") (string-equal (subseq str a b) "u")
					   (string-equal (subseq str a b) "v") (string-equal (subseq str a b) "w") (string-equal (subseq str a b) "x")
					   (string-equal (subseq str a b) "y") (string-equal (subseq str a b) "z")

					   (string-equal (subseq str a b) "0")
					   (string-equal (subseq str a b) "1") (string-equal (subseq str a b) "2") (string-equal (subseq str a b) "3")
					   (string-equal (subseq str a b) "4") (string-equal (subseq str a b) "5") (string-equal (subseq str a b) "6")
					   (string-equal (subseq str a b) "7") (string-equal (subseq str a b) "8") (string-equal (subseq str a b) "9")
					   (string-equal (subseq str a b) "+") (string-equal (subseq str a b) "-") (string-equal (subseq str a b) "*")
					   (string-equal (subseq str a b) "/") (string-equal (subseq str a b) " ") (string-equal (subseq str a b) #\Tab)
					   (string-equal (subseq str a b) "(")
					   (string-equal (subseq str a b) ")")))

									(error "Undefined Token: ~S" (subseq str a b));hata durumu
									  )
								)

		     (setq a (+ a 1))
		     (setq b (+ b 1))

		     (when (> a (- (length str) 1)) (return a))
		  )

	  )
	  ;() ;else
	)
	str ; handle edilmiş olan string geri döndürülür
)

;(write (lexer "a.txt"))
;(terpri)