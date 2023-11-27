(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

;; Problem 15
;; Returns a list of two-element lists

(define (enumerate s)
  ; BEGIN PROBLEM 15
  (define (enumerate-helper lst index)
    (if (null? lst)
        '()
        (cons (list index (car lst)) 
              (enumerate-helper (cdr lst) (+ index 1)))))
  (enumerate-helper s 0))
  ; END PROBLEM 15

;; Problem 16

;; Merge two lists LIST1 and LIST2 according to ORDERED? and return
;; the merged lists.
(define (merge ordered? list1 list2)
  ; BEGIN PROBLEM 16
  (cond
    ((null? list1) list2)  ; If list1 is empty, return list2
    ((null? list2) list1)  ; If list2 is empty, return list1
    (else
      (let ((head1 (car list1))
            (head2 (car list2)))
        (if (ordered? head1 head2)
            (cons head1 (merge ordered? (cdr list1) list2))
            (cons head2 (merge ordered? list1 (cdr list2))))))))
  ; END PROBLEM 16

;; Optional Problem

;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr) expr)  
        ((quoted? expr) expr) 
        ((or (lambda? expr) (define? expr))
         (let ((form (car expr))
               (params (cadr expr))
               (body (cddr expr)))
           (cons form
                 (cons params
                       (map let-to-lambda body))))) 
        ((let? expr)
         (let ((bindings (cadr expr))
               (body (cddr expr)))
           (let ((params (map car bindings))
                 (args (map cadr bindings)))
             (cons (cons 'lambda
                         (cons params
                               (map let-to-lambda body)))
                   args))))  
        (else (map let-to-lambda expr))))

; Some utility functions that you may find useful to implement for let-to-lambda

(define (zip pairs)
  'replace-this-line)
