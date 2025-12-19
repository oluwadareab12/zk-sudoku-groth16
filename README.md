# 🧩 Zero-Knowledge Sudoku Verification (Groth16)

This project implements a **9×9 Sudoku zero-knowledge proof system** using **Circom, snarkJS, and Solidity**, with the verifier deployed on **Arc Testnet**.

A prover can demonstrate knowledge of a valid Sudoku solution **without revealing the solution itself**.

---

## 🚀 Features

- 9×9 Sudoku constraint system written in **Circom**
- Groth16 trusted setup and proof generation using **snarkJS**
- Solidity verifier auto-generated from the circuit
- Verifier contract deployed using **Foundry**
- On-chain verification logic callable on Arc Testnet

---

## 🛠 Tech Stack

- **Circom** – circuit definition
- **snarkJS** – Groth16 proof system
- **Solidity** – verifier contract
- **Foundry** – deployment & scripting
- **Arc Testnet**

---

## 📂 Project Structure

```text
circuits/        Sudoku circuit (Circom)
artifacts/       R1CS, WASM, and symbol files
contracts/       Solidity Groth16 verifier
scripts/         Foundry verification script
screenshots/     Execution and deployment evidence
