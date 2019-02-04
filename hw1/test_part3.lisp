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
(defun insert-n (lst number index)
	(setf beforeIndexList '()) ;listenin icinde indexe kadar giderken uzerinden gecilen elemanlar bu listeye atilir sonrasinda merge isleminde kullanmak icin
	(setf lst (insert-n-helper lst number index)) ;insert-n fonksiyonunun helper methodu cagirilir ve en son istenen listeyi lst ye atarim	
	lst;return edilir
)

(defun insert-n-helper (lst number index)
	(cond ((= index 0) ;eger index 0 sa eklenmek istenen indexe gelinmis demektir
			(push number lst) ;eklenmek istenene indexe push yapilir
		    (merge-list beforeIndexList lst ) ; uzerinden gecilen elemanlar beforeIndexList listesine atilmisti ve o liste ile number in oldugu liste merge edilir
		  )
	      (
	     	(add-to-end (car lst)) ;eger henuz istenilen indexte degilse add-to-end methodu cagirilir bu method beforeIndexList listesinin sonuna uzerinden gecilen elemani atar
	    	(insert-n-helper (cdr lst) number (- index 1)) ; listenin geri kalan elemanlari tekrar insert-n-helper methoduna gonderilir ve index bir azaltilir her recursive cagrida istenilen indexe 1 yaklasmak icin
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



(defun merge-list (list1 list2)
	(cond ((= (list-length list1) 0) list2);ilk fonksiyon cagrisinda list1 bossa list2 return edilir.cunku bos list1 ile list2 nin merge edilmesiyle list2 olusur tekrardan.
		  ((= (list-length list2) 0) list1);her recursive cagrisinda list2'nin size'i 1 azalir cunku list1'nin sonuna eklenmis olur, eger list2 bossa merge islemi tamamlanmistir ve list1 return edilir. yada ilk fonksiyon cagrisinda list2 bossa list1 return edilir.Cunku bos list2 ile list1 in merge edilmesyile list1 return edilir tekrardan.
		  ((add-to-end (car list2));list1 in sonuna list2 nin ilk elemanini ekler
		  	(merge-list list1 (cdr list2));list1 ve list2 nin basindaki eleman olmadan recursive olarak methoda tekrar gonderilirler.
		  )
	)
)

;; MAIN FUNCTION
(defun main ()
  (with-open-file (stream #p"input_part3.csv")
    (loop :for line := (read-csv-line stream) :while line :collect
      (format t "~a~%"
      ;; CALL YOUR (MAIN) FUNCTION HERE

      	(insert-n (read-from-string (nth 0 line)) (read-from-string (nth 1 line)) (read-from-string (nth 2 line)))

      )
    )
  )
)

;; CALL MAIN FUNCTION
(main)
