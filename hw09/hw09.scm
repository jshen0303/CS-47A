(define (ascending? asc-lst)
  (cond ((null? asc-lst) #t) 
        ((null? (cdr asc-lst)) #t) 
        ((> (car asc-lst) (car (cdr asc-lst))) #f)
        (else (ascending? (cdr asc-lst))) 
  )
)

(define (my-filter pred s)
  (cond ((null? s) '()) 
        ((pred (car s)) (cons (car s) (my-filter pred (cdr s)))) 
        (else (my-filter pred (cdr s))) 
  )
)

(define (interleave lst1 lst2)
  (if (null? lst1) 
      lst2
      (if (null? lst2) 
          lst1
          (cons (car lst1) 
                (cons (car lst2) 
                      (interleave (cdr lst1) (cdr lst2))))))) 

(define (no-repeats lst)
  (let ((seen '())) 
    (define (add-to-seen? item)
      (if (member item seen)
          #f
          (begin
            (set! seen (cons item seen))
            #t)))
    (my-filter add-to-seen? lst)))

(define (member item lst)
  (cond ((null? lst) #f)
        ((equal? item (car lst)) #t)
        (else (member item (cdr lst)))))
