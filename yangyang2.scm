#lang planet neil/sicp

;=============================================================================
;(string-append "[ PROCEDURE (true) : " name )
; 체크 함수 
(define (check name target answer)
  (if (= target answer)
      (list "[ TRUE  ] PROCEDURE : " name)
      (list "[ FALSE ] PROCEDURE : " name target "vs" answer )
   )
)
;=============================================================================


; 연습문제 1.7
; 아주 작은수, 큰수의 제곱근을 구할때 good-enough?가 바른 답을 내지 못하는 것을 보기를 들어 설명하라
; good-enough?를 개선하여 어림 값을 지속적인 수정을 통해서 어림 값이 거의 나아지지 않을때까지 계산을
; 이어나가게끔 고쳐보아라. 고친후에는 전보다 잘 돌아가는가?

(define (square x) (* x x) )

; origin
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)
  )
)
; 연습문제 1.7
(define (sqrt-iter2 guess x)
  (if (better-enough? guess x)
      guess
      (sqrt-iter2 (improve guess x) x)
  )
)

(define (improve guess x)
  (average guess (/ x guess) )
)

(define (average a b)
  (/ (+ a b) 2)
)

; origin, 원래 수인 x와 비교
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.0001 )
)

; 연습문제 1.7, improve를 한번더 돌린 값의 제곱과 비교
(define (better-enough? guess x)
  (< (abs (- (square guess) (square (improve guess x)) )) 0.0001 )
)

;origin
(define (sqrt x)
  (sqrt-iter 1.0 x)
)

; 연습문제 1.7
(define (sqrt2 x)
  (sqrt-iter2 1.0 x)
)

;oring
(sqrt 0.0000000001)

; 연습문제 1.7
(sqrt2  0.0000000001)

; 생각보다 크게 달라지는거 같지는 않다. 어쩌면 더 나은 방식으로 짜는게 있을 것 같다.

;=============================================================================

; 연습문제 1.8
; 세제곱근 cube root을 구하는 뉴튼 법은 x의 세제곱근에 가까운 값을 y라고 할때
; (/ (+ (/ x (squre y) ) (* 2 y) ) ) ) 에 따라서 y보다 가까운 값을 계산한다.
; 이 식을 써서 세제곱근 프로시저를 짜보자.

; 세제곱과 오차범위 이내로 같은값인지 비교하는 프로시저
(define (check-enough? guess target)
  (< (abs (- (cube guess) target ) ) 0.000001 )
)

; 비교값이 다를때 근사치를 구하는 프로시저
(define (cubeImprove guess target)
  (/
   (+ (/ target (square guess)) (* 2 guess) )
   3
  )
)

; 비교값에 따라서 재귀, 또는 리턴 하는 프로시저
(define (cube-iter guess target)
  (if (check-enough? guess target)
      (exact->inexact guess) ; 분수로 나와서 소수점 나오게 수정
      (cube-iter (cubeImprove guess target) target)
  )
)


; 세제곱하는 프로시저
(define (cube x) (* x x x) )


;체크
(check "cube" (cube 3) 27 )
(check "cubeImprove" (cubeImprove 1 10) 4 )
(check "cube-iter" (cube-iter 2 8) 2 )
(check "cube-iter" (cube-iter 5 125) 5 )

(cube-iter 2 13)

;=============================================================================

; recusive or iteration process

; recusive process
; 조건이 중족되기 전까지는 계산이 지연되어 이후 한번에 작동, 시작됨
(define (factorialR n)
  (if (= n 1)
      1
      (* n (factorialR (- n 1) ) )
  )
)

; iteration process
; 조건이 충족되기 전까지 계산된 결과값을 계속 누적해서 넘겨준다. 조건 충족시 바로 리턴.
(define (factorialI n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product) (+ counter 1) max-count)
  )
)



; 연습문제 1.9
; 두 프로시스의 계산 프로세스를 밝혀라. 이 프로세스는 반복하는가? 되도는가?

(define (inc a)
  (+ a 1)
)

(define (dec a)
  (- a 1)
)

; 이 프로세스는 되도는 프로세스이다.  linear recusive process
; b가 리턴되기 전까지는 계산이 유보되기 때문이다.
(define (plus1 a b)
  (if (= a 0)
      b
      (inc (plus1 (dec a) b) )
  )
)


; 이 프로세스는 반복하는 프로세스이다. linear iterative process
; 계산과정을 보면 알겠지만, b 값이 커지면서 일종의 계산 결과 값이 된다.
; b의 상태가 지속적으로 변경되며 마지막에는 그 변경된 b값이 바로 반환된다.b가 일종의 결과값으로 리턴되는 것이다.

(define (plus2 a b)
  (if (= a b)
      b
      (plus2 (dec a) (inc b) )
  )
)


; 연습문제 1.10
; 애커만 함수 Ackermann function

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y ))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))
  )
)

;(A 1 10)   ; 2의 n 승을 나타낸다.
;(A 2 4)    ; 
;(A 3 3)

(define (f n) (A 0 n))   ; 2n
(define (g n) (A 1 n))   ; 2^n
(define (h n) (A 2 n))   ; 
(define (k n) (* 5 n n)) ; 5n^2

;(A 2 3)
;(A 1 (A 2 2))
;     (A 1 (A 2 1) )
;(A 1 (A 1 2)
;     (A 0 (A 1 1) )
;     (A 0 2)
     
;(A 1 4) => 2^4
;(A 0 (A 1 3)
;     (A 0 (A 1 2)
;          (A 0 (A 1 1))

;(A 2 1) ==> 2
;(A 2 2) ==> 4
;(A 2 3) ==> 16

;(A 2 4)                ==> 2 ^ (2 ^ 16)
;(A 1 (A 2 3)           ==> 2 ^ 16
;    (A 1 (A 2 2))      ==> 2 ^ 4
;        (A 1 (A 2 1) ) ==> 2 ^ 2

;(A 1 n) 은 2^n 이다.
;위의 과정들을 보면 결국 (A 1 n) 중 n 의 자리에 이전 계산값이 들어가는 것을 알 수 있다.

;(A 2 0) = 0                                              = 0
;(A 2 1) = 2                                              = 2
;(A 2 2) = 2 ^ (A 2 1) ==> 2 ^ 2                          = 4
;(A 2 3) = 2 ^ (A 2 2) ==> 2 ^ (2 ^ 2 )                   = 16
;(A 2 4) = 2 ^ (A 2 3) ==> 2 ^ (2 ^ (2 ^ 2))              = 65536

; 답: n이 2이상의 자연수일 때, 2^(2^(2^....(^2)을 n-1번 반복한다. 하지만 수학 공식으로는 어떻게 하는지 잘 모르겠다.