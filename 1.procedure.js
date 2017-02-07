// 1.프로시저를 써서 요약하는 방법.

// 연습문제1.1 (26p)

console.log(10);

console.log(5+3+4);

console.log(9-1);

console.log(6/2);

console.log( (2*4) + (4-6));

const a = 3;
const b = a + 1;
console.log(a + b + (a * b));
console.log(a === b);

(b > a && b < (a * b)) ? console.log(b) : console.log(a);

if (a === 4) {
  console.log(6);
} else if (b === 4) {
  console.log(6 + 7 + a);
} else {
  console.log(25);
}

console.log(2 + ((b > a) ? b : a));

console.log(((a > b) ? a : (a < b) ? b : -1) * (a + 1));

// 연습문제 1.2 (27p)

const changed = (5 + 4 + (2 - (3 - (6 + 4/5))))/(3 * (6 - 2) * (2 - 7));

// 연습문제 1.3 (28p)
function sumSquareBig2Nums(...args) {
  const arr = [...args];
  const sorted = arr.sort((f,b) => b-f);
  return Math.pow(sorted[0], 2) + Math.pow(sorted[1], 2);
}

// 연습문제 1.4 (28p)

function a_plus_abs_b(a, b) {
  return a + ((b > 0) ? b : -b);
}

// 연습문제 1.5 (28p)

function p() {
  return p();
}

function test(x ,y) {
  return (x === 0) ? x : y;
}

console.log(test(0, p));
// console.log(test(0, p()));
