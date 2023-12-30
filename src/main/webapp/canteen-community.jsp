<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>交流社区</title>
  <style>
    body {
      background-color: #f4f4f4;
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
    }

    header {
      background-color: #333;
      color: white;
      padding: 10px;
      text-align: center;
      height: 130px;
    }

    .search-bar {
      margin-top: 10px;
    }

    input[type="text"] {
      padding: 5px;
    }

    button {
      padding: 5px;
      cursor: pointer;
    }

    #posts {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-around;
      margin: 20px;
    }

    .post {
      border: 1px solid #888;
      padding: 10px;
      margin: 10px;
      width: 600px;
      min-height: 300px;
      background: #fff;
      position: relative;
    }

    .post-content{
      background: #f4f4f4;
      margin: 10px;
      height: 200px;
    }

    .post-actions {
      display: flex;
      justify-content: space-between;
      position: relative;
      margin: 10px 35px;
    }

    .timestamp {
      color: #888;
    }
    section {
      margin: 15px;
    }
    .modal {
      display: none;
      position: fixed;
      z-index: 1;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0,0,0,0.8);
    }

    .modal-content {
      background-color: #fefefe;
      margin: 15% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 80%;
    }

    .close {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
      cursor: pointer;
    }

    .close:hover {
      color: black;
    }
    button.search-button {
      background-color: #4CAF50; /* Green background */
      color: white;
      border: none;
      padding: 8px 16px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 14px;
      margin-left: 5px;
      cursor: pointer;
    }

    /* Style for the View Details button */
    button.view-details-button {
      background-color: #008CBA; /* Blue background */
      color: white;
      border: none;
      padding: 8px 16px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 14px;
      cursor: pointer;
    }

    /* Style for the modal close button */
    .close {
      background-color: #f44336; /* Red background */
      color: white;
      float: right;
      font-size: 28px;
      font-weight: bold;
      cursor: pointer;
    }

    .close:hover {
      background-color: #d32f2f; /* Darker red background on hover */
      color: white;
    }
  </style>
</head>
<body>
<header>
  <h1>交流社区</h1>
  <div class="search-bar">
    <input type="text" placeholder="Search...">
    <button class="search-button">搜索</button>
    <button class="search-button" onclick="sortByPopularity()">热度排序</button>
    <button class="search-button" onclick="sortByTime()">时间排序</button>
    </div>
  </div>
</header>

<section id="posts">
  <div class="post">
    <div class="user-info">
      <h2><span class="user">John Doe</span></h2>
      <span class="timestamp">2 hours ago</span>
      <p id="title"></p>
    </div>
    <div class="post-content">
      <p>This is a sample post content. Lorem ipsum dolor sit amet...</p>
    </div>
    <div class="post-actions">
      <button class="view-details-button" onclick="showPostDetails(1)">查看</button>
      <button class="view-details-button" onclick="showPostDetails(1)">评论</button>
      <button class="view-details-button" onclick="showPostDetails(1)">点赞</button>
    </div>
  </div>
</section>

<div id="post-details-modal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closePostDetailsModal">&times;</span>
    <h2>Post Details</h2>
    <div id="post-details-content">
      <!-- Post details will be loaded here using JavaScript -->
    </div>
  </div>
</div>
</body>
<script>
  // JavaScript functions for interacting with the page
  function showPostDetails(postId) {
    // Simulated data for post details
    const postDetails = {
      id: postId,
      content: "This is a detailed post content. Lorem ipsum dolor sit amet...",
      timestamp: "2 hours ago",
      // Add more details as needed
    };

    // Populate post details in the modal
    document.getElementById('post-details-content').innerHTML = `
        <p>${postDetails.content}</p>
        <p><strong>Timestamp:</strong> ${postDetails.timestamp}</p>
        <!-- Add more details... -->
    `;

    // Show the modal
    document.getElementById('post-details-modal').style.display = 'block';
  }

  function closePostDetailsModal() {
    // Close the modal
    document.getElementById('post-details-modal').style.display = 'none';
  }

</script>
</html>
