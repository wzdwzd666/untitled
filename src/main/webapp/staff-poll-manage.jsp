<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>发布投票</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 600px;
      margin: 50px auto;
      background-color: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
      color: #333;
    }

    form {
      display: flex;
      flex-direction: column;
    }

    label {
      margin-bottom: 8px;
      font-weight: bold;
    }

    input[type="text"] {
      padding: 8px;
      margin-bottom: 16px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
    }

    #optionsContainer {
      margin-bottom: 20px;
    }

    #options {
      display: flex;
      flex-direction: column;
    }

    .option {
      display: flex;
      margin-bottom: 8px;
    }

    button {
      padding: 8px;
      background-color: #4caf50;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    button:hover {
      background-color: #45a049;
    }

    button[type="button"] {
      background-color: #2196F3;
    }

    button[type="button"]:hover {
      background-color: #0b7dda;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>发布投票</h2>

  <form id="createVoteForm">
    <label for="question">调查问题:</label>
    <input type="text" id="question" name="question" required>

    <div id="optionsContainer">
      <label for="options">选项:</label>
      <div id="options">
        <div class="option">
          <input type="text" name="option" required>
          <button type="button" onclick="removeOption(this)">移除</button>
        </div>
      </div>
      <button type="button" onclick="addOption()">添加选项</button>
    </div>

    <button type="button" onclick="publishVote()">发布投票</button>
  </form>
</div>

<script>
  function addOption() {
    const optionsContainer = document.getElementById('options');
    const newOption = document.createElement('div');
    newOption.classList.add('option');
    newOption.innerHTML = `
        <input type="text" name="option" required>
        <button type="button" onclick="removeOption(this)">移除</button>
    `;
    optionsContainer.appendChild(newOption);
  }

  function removeOption(button) {
    const optionDiv = button.parentNode;
    optionDiv.parentNode.removeChild(optionDiv);
  }

  function publishVote() {
    const question = document.getElementById('question').value;
    const optionsInputs = document.getElementsByName('option');

    const optionsArray = Array.from(optionsInputs)
            .map(input => input.value.trim())
            .filter(Boolean);

    if (question && optionsArray.length >= 2) {
      const voteData = {
        question,
        options: optionsArray
      };

      console.log('Vote published:', voteData);
      alert('投票已成功发布！');
    } else {
      alert('请填写问题并提供至少两个选项。');
    }
  }
</script>
</body>
</html>
