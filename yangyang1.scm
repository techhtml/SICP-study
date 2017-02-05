#lang planet neil/sicp

; 연습문제 1.1

10
(+ 5 3 4)
(- 9 1)
(/ 6 2)
(+ (* 2 4) (- 4 6))
(define a 3)
(define b (+ a 1))
(+ a b (* a b))
(= a b)
(if (and (> b a) (< b (* a b)))
    b a
)
(cond
  ((= a 4) 6)
  ((= b 4) (+ 6 7 a))
  (else 25)
)
(+ 2 (if (> b a) b a))
(*
  (cond ((> a b) a)
        ((< a b) b)
        (else -1)
  )
  (+ a 1)
)
;=============================================================================

; 연습문제 1.2
; 아래식을 '앞가지 쓰기' 꼴로 고쳐써보자

(/
  (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5) ) ) ) )
  (* 3 (- 6 2) (- 2 7))
)
;=============================================================================

; 연습문제 1.3
; 세숫자를 인자로 받아 그 중 큰 숫자 두개를 제곱, 두 값을 덧셈하여 내놓는 프로시저 정의
(define (twoOut a b c)
  (define (sqrt x) (* x x))
  
  (cond
    ((and (> a c) (> b c)) (+ (sqrt a) (sqrt b)))
    ((and (> a b) (> c b)) (+ (sqrt a) (sqrt c)))
    ((and (> b a) (> c a)) (+ (sqrt b) (sqrt c)))
  )
)
;=============================================================================

; 연습문제 1.4
; 다음 프로시저에 인자를 주고 어떻게 계산되는지 밝혀보라.
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b)
)

; 연산자 자리에 조건문이 왔고 b의 값에 따라서 +, -를 반환하므로 b의 값이 양일때는 +,
; 음일때는 - 값을 받아서 b가 절대값으로서 a에 더할수 있게 된다.
;=============================================================================

; 연습문제 1.5
; 다음두 프로시저를 실행했을때 applicative order evaluation, normal-order evaluation
; 에 따라서 각각 계산하였을때 나오는 결과와 그 이유를 밝혀보라

(define (p) (p))

(define (test x y)
  (if (= x 0) 0 y)
)

;(test 0 (p))

; applicative order evaluation 으로 했을 경우
; 인자들의 값을 먼저 계산하고 나서 test가 실행되는데 (p)가 재귀함수라서 무한루프를 돈다.

; normal-order evaluation 으로 했을 경우
; 정의대로 할 경우 (if (= 0 0) 0 (p) ) 가 되므로 (p)가 실행되지 않고 0을 반환하고 끝난다.
;=============================================================================


; 연습문제 1.6
; new-if 프로시저를 if 문 대신에 사용할 경우 어떤 일어나는지 설명하라.

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)
  )
)

(define (square x) (* x x) )

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)
  )
)

(define (improve guess x)
  (average guess (/ x guess) )
)

(define (average a b)
  (/ (+ a b) 2)
)

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.000000001 )
)

(define (sqrt x)
  (sqrt-iter 1.0 x)
)

; (sqrt 3) new-if를 사용해서 실행할 경우에 무한 루프에 빠진다.
; 이것도 인자를 감싼 함수를 호출하기 전에 먼저 인자들에 대해서 계산을 진행하기 때문인데,
; 인자를 계산하는 중에 sqrt-iter를 호출하면서 new-if를 통한 비교를 하지 못하고 계속 호출하는 것이다.
;====================================================================================