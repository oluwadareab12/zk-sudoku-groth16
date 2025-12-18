pragma circom 2.0.0;

include "bitify.circom";
include "comparators.circom";

template ValidCell() {
    signal input in;

    // Ensure in < 10
    component lt = LessThan(4);
    lt.in[0] <== in;
    lt.in[1] <== 10;
    lt.out === 1;

    // Ensure in != 0
    component nz = IsZero();
    nz.in <== in;
    nz.out === 0;
}

template Sudoku9x9() {
    signal input board[81];
    signal output valid;

    component cells[81];

    for (var i = 0; i < 81; i++) {
        cells[i] = ValidCell();
        cells[i].in <== board[i];
    }

    valid <== 1;
}

component main = Sudoku9x9();
