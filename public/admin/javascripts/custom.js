$(function(){
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
});