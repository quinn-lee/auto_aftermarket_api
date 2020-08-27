$(function(){
    $('[data-toggle="popover"]').popover();

    // 表单上传图片预览
    function image_preview(file,ele) {
        var img = new Image(), url = img.src = URL.createObjectURL(file);
        var $img = $(img);
        img.onload = function() {
            URL.revokeObjectURL(url);
            ele.replaceWith($img);
        }
    }
    $(".inbox-file").bind("change",function(e){
        var files = e.target.files;
        var preview_wrapper = $(this).parent().parent().parent('.image-preview');
        preview_wrapper.children('img').remove();
        for(var i = 0; i < files.length; i++){
            var content = '<img src="" id="img_preview_' + i + '" class="thumbnail">';
            preview_wrapper.append(content);
            var ele = $('#img_preview_' + i);
            image_preview(files[i], ele);
        }
    });

    // 点击选择图片进行排序
    $('.thumbnail-filter').bind('click', function(){
        var _seq_input_ = $('input[name=_seq_]');
        var _seq_ = _seq_input_.val() ? _seq_input_.val().split(',') : [];
        var _len_ = $('.thumbnail-filter').length;
        var _id_  = this.id.split('_')[1];
        // 更新样式 + 排序
        if(this.className.includes('active')){
            $(this).removeClass('active');
            $(this).html('');
            _seq_.splice(_seq_.indexOf(_id_), 1);
        }else{
            $(this).addClass('active');
            _seq_.push(_id_);
        }
        _seq_input_.val(_seq_);
        // 刷新显示序号
        _seq_.forEach(function(i){
            $('#filter_' + i).html(_seq_.indexOf(i) + 1);
        });
        // 全排序后激活提交按键
        document.getElementById('filter_submit').disabled = _seq_.length != _len_;
    });
});

function load_second_cell(id){
    $(".first-cell").each(function() {
        $(this).removeClass("active");
    });
    $(".first-cell_"+id).addClass("active");
    $.ajax({
        type:'GET',
        dataType:'json',
        async: false,
        url:'/admin/categories/load_second_cell?id='+id,
        success:function(data){
            var cell_form = $(".second-index");
            var sub_c = data['sub_categories'];
            var is_hidden = data['is_hidden'];
            var can_delete = data['can_delete'];
            cell_form.html('')
            for(let i = 0 ; i < sub_c.length ; i++){
                cell_form.append("<div class='second-cell second-cell_"+ sub_c[i]['id'] +"' onclick='load_third_cell(" +sub_c[i]['id']+")'>"+sub_c[i]['name']+"</div>")
            }
            $("#second-new").attr('href' , "/admin/categories/new?parent_id=" + id)
            if(is_hidden){
                $("#second-hide").attr('href' , "/admin/categories/hidden/"+id+"?is_hidden=false")
                $("#second-hide").html('<i class="fa fa-tag"></i>展示目录')
            }else{
                $("#second-hide").attr('href' , "/admin/categories/hidden/"+id+"?is_hidden=true")
                $("#second-hide").html('<i class="fa fa-tag"></i>隐藏目录')
            }
            if (can_delete) {
                $("#second-delete").attr('href' , "/admin/categories/delete/"+id)
                $("#second-delete").attr('style' , "color:#333")
            }else{
                $("#second-delete").attr('href' , "#")
                $("#second-delete").attr('style' , "color:red")
            }
        }
    })
}

function load_third_cell(id){
    $(".second-cell").each(function() {
        $(this).removeClass("active");
    });
    $(".second-cell_"+id).addClass("active");
    $.ajax({
        type:'GET',
        dataType:'json',
        async: false,
        url:'/admin/categories/load_third_cell?id='+id,
        success:function(data){
            var form_brand = $(".form-brand");
            var brands = data['brands'];
            form_brand.html('');
            for(let i = 0 ; i < brands.length ; i++){
                form_brand.append("<button class='cell-col'>" + brands[i].name + "</button>")
            }

            var form_attr = $(".form-attr");
            var attrs = data['attrs'];
            form_attr.html('');
            for(let i = 0 ; i < attrs.length ; i++){
                form_attr.append("<button class='cell-col-attr' data-toggle='modal' data-target='#showAttribute' onclick='load_attr_modal("+attrs[i].id+")'>" + attrs[i].name + "</button>")
            }

            var form_operate = $(".form-operate");
            var is_hidden = data['is_hidden'];
            var can_delete = data['can_delete'];
            form_operate.html('');
            if(can_delete){
                form_operate.append("<a href='/admin/categories/delete/"+id+"' class='pd-setting-ed'>删除</a>")
            }
            if(is_hidden){
                form_operate.append("<a href='/admin/categories/hidden/"+id+"?is_hidden=false' class='pd-setting-ed'>展示</a>")
            }else{
                form_operate.append("<a href='/admin/categories/hidden/"+id+"?is_hidden=true' class='pd-setting-ed'>隐藏</a>")
            }
            form_operate.append("<a href='/admin/categories/new_attribute/"+id+"' class='pd-setting-ed'>添加属性</a>")
            form_operate.append("<a href='/admin/categories/new_brands/"+id+"' class='pd-setting-ed'>添加品牌</a>")
            form_operate.append("<a href='/admin/spus?category_2="+id+"' class='pd-setting-ed'>查看商品</a>")
        }
    })
}

function load_attr_modal(id){
    $.ajax({
        type:'GET',
        dataType:'json',
        async: false,
        url:'/admin/categories/load_attr?id='+id,
        success:function(data){
           $(".attr-name").html(data['name'])
           $(".attr-selling_desc").html(data['selling_desc'])
           $(".attr-searching_desc").html(data['searching_desc'])
           $(".attr-unit").html(data['unit'])
           $(".attr-t_attrvalues").html(data['t_attrvalues'])
           $(".attr-form").attr('action' , "/admin/categories/create_attrvalues/"+ id)
        }
    })
}
