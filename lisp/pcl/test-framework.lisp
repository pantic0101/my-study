;; test

(defun test-+ ()
  (and 
   (= (+ 1 2) 3)
   (= (+ 1 2 3) 6)
   (= (+ -1 -3) -4)))

(defun test-+ ()
  (format t "~:[FAIL~;pass~] ... ~a~%" (= (+ 1 2) 3) '(= (+ 1 2) 3))
  (format t "~:[FAIL~;pass~] ... ~a~%" (= (+ 1 2 3) 6) '(= (+ 1 2 3) 6))
  (format t "~:[FAIL~;pass~] ... ~a~%" (= (+ -1 -3) -4) '(= (+ -1 -3) -4)))


(defun test-+ ()
  (report-result (= (+ 1 2) 3) '(= (+ 1 2) 3))
  (report-result (= (+ 1 2 3) 6) '(= (+ 1 2 3) 6))
  (report-result (= (+ -1 -3) -4) '(= (+ -1 -3) -4)))

(defmacro check (form)
  `(report-result ,form ',form))

(defun test-+ ()
  (check (= (+ 1 2) 3))
  (check (= (+ 1 2 3) 5))
  (check (= (+ -1 -3) -4)))


(defmacro check (&body forms)
  `(progn
	 ,@(loop for f in forms collect `(report-result ,f ',f))))





(defvar *test-name* nil)

(defun report-result (result form)
  "Report the results of a single test case. Called by 'check'."
  (format t "~:[FAIL~;pass~] ... ~a: ~a~%" result *test-name* form)
  result)

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
	 ,@body))

(defmacro combine-results (&body forms)
  "Combine the results (as booleans) of evaluating 'forms' in order."
  (with-gensyms (result)
	`(let ((,result t))
	   ,@(loop for f in forms collect
			`(unless ,f (setf ,result nil)))
	   ,result)))

(defmacro check (&body forms)
  "Run each expression in 'forms' as a test case."
  `(combine-results
	 ,@(loop for f in forms collect `(report-result ,f ',f))))

(defmacro deftest (name parameters &body body)
  "Define a test function. Within a test function we can call other test
functions or use 'check' to run individual test cases."
  `(defun ,name ,parameters
	 (let ((*test-name* (append *test-name* (list ',name))))
	   ,@body)))

(deftest test-+ ()
  (check
	(= (+ 1 2) 3)
	(= (+ 1 2 3) 6)
	(= (+ -1 -3) -4)))

(deftest test-* ()
  (check
	(= (* 2 2) 4)
	(= (* 3 5) 12)))

(deftest test-arithmetic ()
  (combine-results
	(test-+)
	(test-*)))

(deftest test-math ()
  (test-arithmetic))
