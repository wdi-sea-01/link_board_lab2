$(function(){
    $('.ajax-vote').on('click',function(e){
        e.preventDefault();
        e.stopPropagation();
        var link = $(this);
        var url = link.attr('href');
        $.post(url, {}, function(response){
            //response.result , response.votes
            link.next('.vote-count').text(response.votes);

            if(response.result){
                link.before('<i class="glyphicon glyphicon-chevron-up" style="color: #CCCC88;"></i>');
                link.remove();
            }else{
                alert('You already voted on this.')
            }
        },'json');
    })
});