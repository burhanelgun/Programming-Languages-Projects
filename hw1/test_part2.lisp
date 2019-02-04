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

(defun merge-list (list1 list2)
	(cond ((= (list-length list1) 0) list2);ilk fonksiyon cagrisinda list1 bossa list2 return edilir.cunku bos list1 ile list2 nin merge edilmesiyle list2 olusur tekrardan.
		  ((= (list-length list2) 0) list1);her recursive cagrisinda list2'nin size'i 1 azalir cunku list1'nin sonuna eklenmis olur, eger list2 bossa merge islemi tamamlanmistir ve list1 return edilir. yada ilk fonksiyon cagrisinda list2 bossa list1 return edilir.Cunku bos list2 ile list1 in merge edilmesyile list1 return edilir tekrardan.
		  ((push (car list2) (cdr (last list1)));list1 in sonuna list2 nin ilk elemanini ekler
		  	(merge-list list1 (cdr list2));list1 ve list2 nin basindaki eleman olmadan recursive olarak methoda tekrar gonderilirler.
		  )
	)
)

;; MAIN FUNCTION
(defun main ()
  (with-open-file (stream #p"input_part2.csv")
    (loop :for line := (read-csv-line stream) :while line :collect
      (format t "~a~%"
      ;; CALL YOUR (MAIN) FUNCTION HERE

      	(merge-list (read-from-string (nth 0 line)) (read-from-string (nth 1 line)))

      )
    )
  )
)

;; CALL MAIN FUNCTION
(main)
