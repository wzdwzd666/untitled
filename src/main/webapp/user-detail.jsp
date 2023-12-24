<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    /* 下拉菜单外层容器 */
    .custom-select {
      position: relative;
      width: 150px;
      text-align: center;
    }

    /* 自定义样式的选择按钮 */
    .custom-select .select-box {
      display: flex;
      align-items: center;
      justify-content: space-between;
      width: 100%;
      padding: 8px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-sizing: border-box;
      cursor: pointer;
    }

    /* 下拉选项容器 */
    .custom-select .options {
      position: absolute;
      top: 100%;
      left: 0;
      display: none;
      width: 100%;
      border: 1px solid #ccc;
      border-top: none;
      border-radius: 0 0 5px 5px;
      box-sizing: border-box;
      background-color: #fff;
      z-index: 1;
    }

    /* 下拉选项 */
    .custom-select .options div {
      padding: 8px;
      cursor: pointer;
    }

    .custom-select .options div:hover {
      background-color: #f0f0f0;
    }

  </style>
</head>
<body>

<div class="custom-select">
  <div class="select-box">
    <span>Select an option</span>
    <span>&#9660;</span>
  </div>
  <div class="options">
    <div>Option 1</div>
    <div>Option 2</div>
    <div>Option 3</div>
  </div>
</div>

<script>
  // 添加下拉菜单的点击事件
  document.querySelector('.custom-select .select-box').addEventListener('click', function() {
    const optionsContainer = document.querySelector('.custom-select .options');
    optionsContainer.style.display = optionsContainer.style.display === 'block' ? 'none' : 'block';
  });

  // 添加选项点击事件
  const options = document.querySelectorAll('.custom-select .options div');
  options.forEach(function(option) {
    option.addEventListener('click', function() {
      const selectedValue = this.textContent;
      document.querySelector('.custom-select .select-box span:first-child').textContent = selectedValue;
      document.querySelector('.custom-select .options').style.display = 'none';
    });
  });

  // 点击页面其他地方时关闭下拉菜单
  document.addEventListener('click', function(event) {
    const target = event.target;
    if (!target.closest('.custom-select')) {
      document.querySelector('.custom-select .options').style.display = 'none';
    }
  });
</script>

</body>
</html>
