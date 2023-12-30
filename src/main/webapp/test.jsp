<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Community Home</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<header>
    <h1>Community Home</h1>
    <div class="search-bar">
        <input type="text" placeholder="Search...">
        <button>Search</button>
    </div>
</header>

<section id="posts">
    <div class="post">
        <div class="user-info">
            <img src="user_avatar.jpg" alt="User Avatar">
            <span class="username">John Doe</span>
        </div>
        <div class="post-content">
            <p>This is a sample post content. Lorem ipsum dolor sit amet...</p>
            <div class="post-actions">
                <span class="timestamp">2 hours ago</span>
                <button onclick="showPostDetails(1)">View Details</button>
            </div>
        </div>
    </div>

    <!-- More posts... -->

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

<script src="script.js"></script>
</body>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }

    header {
        background-color: #333;
        color: white;
        padding: 10px;
        text-align: center;
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
        border: 1px solid #ddd;
        padding: 10px;
        margin: 10px;
        width: 500px;
    }

    .user-info img {
        width: 30px;
        height: 30px;
        border-radius: 50%;
        margin-right: 10px;
    }

    .post-actions {
        display: flex;
        justify-content: space-between;
        margin-top: 10px;
    }

    .timestamp {
        color: #888;
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

</style>
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
