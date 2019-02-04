(load "csv-parser.lisp")
(in-package :csv-parser)

;; (read-from-string STRING)
;; This function converts the input STRING to a lisp object.
;; In this code, I use this function to convert lists (in string format) from csv file to real lists.

;; (nth INDEX LIST)
;; This function allows us to access value at INDEX of LIST.
;; Example: (nth 0 '(a b c)) => a

;; !!! VERY VERY VERY IMPORTANT NOTE !!!
;; FOR EACH ARGUMENT IN CSV FILE
;; USE THE CODE (read-from-string (nth ARGUMENT-INDEX line))
;; Example: (mypart1-funct (read-from-string (nth 0 line)) (read-from-string (nth 1 line)))

;; DEFINE YOUR FUNCTION(S) HERE

(defun list-leveller (lst)
	
	(setq beforeIndexList '()) ;listenin icinde en son elemana giderken karsilasilan elemanlari saklamak icin kullanilan listedir
	(list-leveller-helper lst) ;list-leveller fonkisyonun helper fonskiyonu cagirilir
	(setf lst beforeIndexList) ;en son istenen listeyi lst ye atarim
	lst;return edilir
)


(defun list-leveller-helper (lst)

	(cond ((= (list-length lst) 0)  ; eger listenin uzunlugu 0 ise tum listedeki elemanlar gezilmis ve beforeIndexList listesine atilmis demektir bu yuzden beforeIndexList listesi return edilir
			beforeIndexList
		  )
		  ((cond ((eq (listp (car lst)) T)  ;eger listenin car ile gelen elemani liste ise o liste ve ondan sonraki elemanlar sirasiyla tekrar recursive sekilde list-leveller-helper fonksiyonuna gonderilir.
	 		  		(list-leveller-helper (car lst))
		 		  	(list-leveller-helper (cdr lst))
				 )

		 		 (
		 		  			
		 		  	(add-to-end (car lst)) ;eger listenin car ile gelen elemani liste degilse o eleman beforeIndexList listesinde saklanir
	 		  		(list-leveller-helper (cdr lst));listenin diger elemanlari tekrar recursive sekilde list-leveller-helper fonksiyonuna gonderilir.

		 		  )
		   )
	  )
	)

)


(defun add-to-end (number) ;beforeIndexList listesinin sonuna ekleme yapan fonksiyon
	(cond ((eq beforeIndexList NIL)
			(push number beforeIndexList) ;eger beforeIndexList listesi bossa beforeIndexList listesine ilk elemani push ile ekleriz
		  )
	      (
		(push  number (cdr (last beforeIndexList))) ; beforeIndexList listesinin en sonuna ekleme yapar
	      )
	)
)

;; MAIN FUNCTION
(defun main ()
  (with-open-file (stream #p"input_part1.csv")
    (loop :for line := (read-csv-line stream) :while line :collect
      (format t "~a~%"
      ;; CALL YOUR (MAIN) FUNCTION HERE

      	(list-leveller (read-from-string (nth 0 line)))

      )
    )
  )
)

;; CALL MAIN FUNCTION
(main)
