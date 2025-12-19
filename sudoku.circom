pragma circom 2.0.0;

template IsEqual() {
    signal input a;
    signal input b;
    signal output out;

    out <== 1 - (a - b)*(a - b); // 1 if equal, 0 otherwise
}

template Mul2() {
    signal input a;
    signal input b;
    signal output out;

    out <== a * b;
}

template Sudoku() {
    signal input grid[9][9];
    signal input solution[9][9];
    signal output ok;

    component eq[9][9];

    var i;
    var j;

    for (i = 0; i < 9; i++) {
        for (j = 0; j < 9; j++) {
            eq[i][j] = IsEqual();
            eq[i][j].a <== grid[i][j];
            eq[i][j].b <== solution[i][j];
        }
    }

    // Multiply all equality outputs using a tree of Mul2 components
    component rowProd[9][8]; // each row produces a single output

    for (i = 0; i < 9; i++) {
        // first multiply eq[i][0]*eq[i][1], eq[i][2]*eq[i][3], ...
        rowProd[i][0] = Mul2();
        rowProd[i][0].a <== eq[i][0].out;
        rowProd[i][0].b <== eq[i][1].out;

        rowProd[i][1] = Mul2();
        rowProd[i][1].a <== eq[i][2].out;
        rowProd[i][1].b <== eq[i][3].out;

        rowProd[i][2] = Mul2();
        rowProd[i][2].a <== eq[i][4].out;
        rowProd[i][2].b <== eq[i][5].out;

        rowProd[i][3] = Mul2();
        rowProd[i][3].a <== eq[i][6].out;
        rowProd[i][3].b <== eq[i][7].out;

        rowProd[i][4] = Mul2();
        rowProd[i][4].a <== rowProd[i][0].out;
        rowProd[i][4].b <== rowProd[i][1].out;

        rowProd[i][5] = Mul2();
        rowProd[i][5].a <== rowProd[i][2].out;
        rowProd[i][5].b <== rowProd[i][3].out;

        rowProd[i][6] = Mul2();
        rowProd[i][6].a <== rowProd[i][4].out;
        rowProd[i][6].b <== rowProd[i][5].out;

        // multiply with eq[i][8] to get final row output
        rowProd[i][7] = Mul2();
        rowProd[i][7].a <== rowProd[i][6].out;
        rowProd[i][7].b <== eq[i][8].out;
    }

    // Multiply all rows together
    component total1 = Mul2();
    total1.a <== rowProd[0][7].out;
    total1.b <== rowProd[1][7].out;

    component total2 = Mul2();
    total2.a <== rowProd[2][7].out;
    total2.b <== rowProd[3][7].out;

    component total3 = Mul2();
    total3.a <== rowProd[4][7].out;
    total3.b <== rowProd[5][7].out;

    component total4 = Mul2();
    total4.a <== rowProd[6][7].out;
    total4.b <== rowProd[7][7].out;

    component total5 = Mul2();
    total5.a <== total1.out;
    total5.b <== total2.out;

    component total6 = Mul2();
    total6.a <== total3.out;
    total6.b <== total4.out;

    component total7 = Mul2();
    total7.a <== total5.out;
    total7.b <== total6.out;

    component total8 = Mul2();
    total8.a <== total7.out;
    total8.b <== rowProd[8][7].out;

    ok <== total8.out;
}

component main = Sudoku();
