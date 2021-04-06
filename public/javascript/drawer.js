$().ready(function () {
    const inst = new mdui.Drawer('#drawerContainer');
    $('#drawerBtn').click(function () {
        inst.toggle();
    })

    const drawerItem = $('#drawer').children().filter('.mdui-list-item')
    const render = {
        home: '/',
        login: '/login',
        register: '/register',
        about: '/about',
        dashboard: '/dashboard'
    }
    drawerItem.each(function () {
        if (render[this.id] !== undefined) {
            $(this).click(() => {
                console.log('yes')
                window.location.replace(render[this.id]);
            })
        }

    })
    if ($('#logout')) {
        $('#logout').click(function () {
            inst.close();
            $.post('/api/logout', function (data) {
                console.log(data);
                if (data.logout) {
                    history:false,
                        mdui.dialog({
                            title: '退出成功',
                            content: '您已经成功退出登录',
                            buttons: [
                                {
                                    text: '返回首页',
                                    close: false,
                                    onClick: () => {
                                        window.location.href = "./";
                                    }

                                }]
                        })
                } else {
                    mdui.dialog({
                        history: false,
                        title: '错误',
                        content: data.errMsg,
                        buttons: [{
                            text: '前往登录',
                            close: false,
                            onClick: () => {
                                window.location.href = '/login?dm=1'
                            }

                        }]
                    })
                }
            })
            // mdui.dialog({
            //     title: '退出登录',
            //     content: '您确定要退出吗？',
            //     buttons: [{
            //         text: "取消",
            //     }, {
            //         text: "确定",
            //         onClick: () => {
            //
            //         }
            //     }]
            // })
        })
    }
})