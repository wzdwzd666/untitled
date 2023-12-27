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
        <c:forEach var="admin" items="${adminList}">
            <tr id="${admin.id}">
                <td >${admin.id}</td>
                <td >${admin.account}</td>
                <td >${admin.name}</td>
                <td >${admin.password}</td>
                <td >编号:${admin.canteenId}
                    <c:forEach var="canteen" items="${canteenList}">
                        <c:if test="${canteen.id==admin.canteenId}">
                            ${canteen.name}
                        </c:if>
                    </c:forEach>
                </td>
                <td>
                    <button onclick="editAdmin('${admin.id}', '${admin.account}', '${admin.name}', '${admin.password}', '${admin.canteenId}')">编辑</button>
                    <button onclick="deleteAdmin('${admin.id}','${admin.name}')">删除</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- 编辑弹窗 -->
    <dialog id="editDialog">
        <h2>编辑管理员信息</h2>
        <label for="newAdminName">新的管理员姓名:</label>
        <input type="text" id="newAdminName" name="newAdminName" required>
        <label for="newPassword">新的管理员密码:</label>
        <input type="text" id="newPassword" name="newPassword" min="6:00" max="11:00" required>
        <div>
            <label>
                更改管理食堂:
                <select id="newCanteenId" name="newCanteenId" >
                    <c:forEach var="canteen" items="${canteenList}">
                        <option value="${canteen.id}">编号:${canteen.id} ${canteen.name}</option>
                    </c:forEach>
                </select>
            </label>
        </div>
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
                <c:forEach var="canteen" items="${canteenList}">
                    <option value="${canteen.id}">编号:${canteen.id} 名字:${canteen.name}</option>
                </c:forEach>
            </select>
        </label>
        <input type="submit" onclick="insertAdmin()" value="新增管理员">
        <input type="submit" onclick="document.getElementById('newDialog').close();" value="取消">
    </dialog>
</section>
<script>
    let adminId;
    let adminAccount
    function editAdmin(id, account, name, password, canteenId) {
        adminId=id
        adminAccount=account
        document.getElementById('newAdminName').value = name;
        document.getElementById('newPassword').value = password;
        document.getElementById('newCanteenId').value = canteenId;
        document.getElementById('editDialog').showModal()
    }
    function saveEdit() {
        console.log(adminId+"保存更改")
        const newName = document.getElementById('newAdminName').value;
        const newPassword = document.getElementById('newPassword').value;
        const newCanteenId = document.getElementById('newCanteenId').value;
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'AdminServlet',true)
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
        xhr.send('type=edit&id='+adminId+'&newAccount='+adminAccount+'&newName='+newName+'&newPassword='+newPassword+'&newCanteenId='+newCanteenId)
        xhr.onreadystatechange = function () {
            if(xhr.readyState===4) {
                if(xhr.status===200) {
                    //更新数据
                    location.reload();
                    alert('编辑成功');
                    document.getElementById('editDialog').close();
                }
            }
        }
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
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'AdminServlet', true)
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
        xhr.send('type=delete&id='+adminId )
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    //删除
                    console.log(adminId+"删除管理员")
                    location.reload();
                    alert('删除成功');
                }
            }
            document.getElementById('deleteDialog').close()
        }
    }
    function insertAdmin() {
        const newAccount = document.getElementById('adminAccount').value
        const newName = document.getElementById('adminName').value;
        const newPassword = document.getElementById('adminPassword').value;
        const newCanteenId = document.getElementById('canteenId').value;
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'AdminServlet', true)
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
        xhr.send('type=insert&id=' + adminId + '&newAccount=' + newAccount + '&newName=' + newName + '&newPassword=' + newPassword + '&newCanteenId=' + newCanteenId)
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    const result = xhr.responseText;
                    console.log(result);
                    if (result === "accountError"||result==="") {
                        console.log(result);
                        alert("账号已经被注册");
                        // 如果出现错误，可以在这里直接返回，以终止函数执行
                        document.getElementById('newDialog').close();
                    }else {
                        console.log(result+"添加管理员")
                        // 更新数据
                        location.reload();
                        alert('新增管理员成功');
                        document.getElementById('newDialog').close();
                    }
                }
            }
        }
    }
</script>
</body>
</html>