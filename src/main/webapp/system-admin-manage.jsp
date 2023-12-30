<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>账号管理</title>
    <link rel="stylesheet" type="text/css" href="assets/css/manage.css">
</head>
<body>
<header>
    <h2>管理员账号列表</h2>
</header>
<section>
    <input type="submit" value="添加新管理员" onclick="document.getElementById('newDialog').showModal()">
    <table id="adminTable">
        <thead>
        <tr>
            <th>管理员编号</th>
            <th>管理员账号</th>
            <th>管理员姓名</th>
            <th>管理员密码</th>
            <th>管理食堂</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <!-- 填充表格 -->
        </tbody>
    </table>

    <!-- 编辑弹窗 -->
    <dialog id="editDialog">
        <h2>编辑管理员信息</h2>
        <label for="newAdminName">新的管理员姓名:</label>
        <input type="text" id="newAdminName" name="newAdminName" required>
        <label for="newPassword">新的管理员密码:</label>
        <input type="text" id="newPassword" name="newPassword" min="6:00" max="11:00" required>
<!--        <div>-->
<!--            <label>-->
<!--                更改管理食堂:-->
<!--                <select id="newCanteenId" name="newCanteenId" >-->
<!--                    <c:forEach var="canteen" items="${canteenList}">-->
<!--                        <option value="${canteen.id}">编号:${canteen.id} ${canteen.name}</option>-->
<!--                    </c:forEach>-->
<!--                </select>-->
<!--            </label>-->
<!--        </div>-->
        <input type="submit" onclick="saveEdit()" value="保存更改">
        <input type="submit" onclick="document.getElementById('editDialog').close();" value="取消">
    </dialog>

    <!-- 删除确认弹窗 -->
    <dialog id="deleteDialog">
        <h2>确认</h2>
        <p>确认删除管理员: <span id="deleteAdminName"></span> 吗？</p>
        <button onclick="confirmAdmin()">确认删除</button>
        <button onclick="document.getElementById('deleteDialog').close();">取消</button>
    </dialog>

    <!-- 新增弹窗 -->
    <dialog id="newDialog">
        <h2>新增管理员</h2>
        <label for="adminAccount">管理员账号:</label>
        <input type="text" id="adminAccount" name="adminAccount" required>
        <label for="adminName">管理员姓名:</label>
        <input type="text" id="adminName" name="adminName" required>
        <label for="adminPassword">管理员密码:</label>
        <input type="text" id="adminPassword" name="adminPassword" required>
        <label>
            设置管理食堂:
            <select id="canteenId" name="canteenId" >
<!--                <c:forEach var="canteen" items="${canteenList}">-->
<!--                    <option value="${canteen.id}">编号:${canteen.id} 名字:${canteen.name}</option>-->
<!--                </c:forEach>-->
            </select>
        </label>
        <input type="submit" onclick="insertAdmin()" value="新增管理员">
        <input type="submit" onclick="document.getElementById('newDialog').close();" value="取消">
    </dialog>
</section>
<script>
    let adminId;
    let adminAccount
    window.onload = function getData(){
        getAdminReviews();
        getCanteenReviews();
    }
    // 使用Fetch API发送请求
    function fetchData(url, options) {
        return fetch(url, options)
            .then(response => response.json())
            .catch(error => console.error('Error:', error));
    }

    // 获取评价信息列表
    function getAdminReviews() {
        // 构造 POST 请求的选项对象
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'getAll',
            }),
        };

        fetchData('AdminServlet', postOptions)
            .then(data => renderReviewList(data));
    }
    function getCanteenReviews(){
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'getAll',
            }),
        };
        fetchData('CanteenServlet', postOptions)
            .then(data => {
                const selectElement = document.getElementById('canteenId');
                // 清除现有的选项
                selectElement.innerHTML = "";
                data.forEach(review => {
                    // 创建一个新的选项元素
                    const option = document.createElement('option');
                    option.value = review.id;
                    option.text = '编号:' + review.id + ' 名字:' + review.name;
                    // 将选项追加到选择框中
                    selectElement.add(option);
                });
            });
    }
    // 渲染评价信息列表
    function renderReviewList(list) {
        console.log("渲染列表")
        console.log(list)
        const tableBody = document.getElementById('adminTable').getElementsByTagName('tbody')[0];
        tableBody.innerHTML = '';

        list.forEach(review => {
            const row = tableBody.insertRow(-1);
            row.id = review.id
            row.insertCell(0).textContent = review.id
            row.insertCell(1).textContent = review.account
            row.insertCell(2).textContent = review.name
            row.insertCell(3).textContent = review.password
            row.insertCell(4).textContent = review.canteen.name;
            row.insertCell(5).innerHTML = "<button onclick=\"editAdmin('"+review.id+"')\">编辑</button>"+
                " <button onclick=\"deleteAdmin('"+review.id+"','"+review.name+"')\">删除</button>"
        });
    }
    function editAdmin(id) {
        adminId=id
        const row=document.getElementById(id)
        document.getElementById('newAdminName').value = row.cells[2].textContent
        document.getElementById('newPassword').value = row.cells[3].textContent
        // document.getElementById('newCanteenId').value = row.cells[4].textContent
        document.getElementById('editDialog').showModal()
    }
    function saveEdit() {
        console.log(adminId+"保存更改")
        const newName = document.getElementById('newAdminName').value;
        const newPassword = document.getElementById('newPassword').value;
        // const newCanteenId = document.getElementById('newCanteenId').value;
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'edit',
                id: adminId,
                name: newName,
                password: newPassword,
            }),
        };
        fetchData('AdminServlet', postOptions)
            .then(data => {
                renderReviewList(data)
                alert("编辑成功")
                document.getElementById('editDialog').close()
            });
    }
    function deleteAdmin(id,name) {
        adminId=id;
        document.getElementById('deleteAdminName').textContent = name;
        document.getElementById('deleteDialog').showModal();
    }
    function confirmAdmin() {
        if(!confirm("确定删除吗")){
            return
        }
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'delete',
                id: adminId,
            }),
        };
        fetchData('AdminServlet', postOptions)
            .then(data => {
                renderReviewList(data)
                alert("删除成功")
                document.getElementById('deleteDialog').close()
            });
    }
    function insertAdmin() {
        const newAccount = document.getElementById('adminAccount').value
        const newName = document.getElementById('adminName').value;
        const newPassword = document.getElementById('adminPassword').value;
        const newCanteenId = document.getElementById('canteenId').value;
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'insert',
                account: newAccount,
                name: newName,
                password: newPassword,
                canteenId: newCanteenId,
            }),
        };
        fetchData('AdminServlet', postOptions)
            .then(data => {
                if(data.message){
                    alert("账号重复!")
                    return
                }
                renderReviewList(data)
                alert("添加成功")
                document.getElementById('newDialog').close()
            });
    }
</script>
</body>
</html>
