 $(function () {
      $('#switch-btn-1').click(function () {
        $(this).toggleClass('switch-on');
        if ($(this).hasClass('switch-on')) {
          $(this).trigger('on.switch');
        } else {
          $(this).trigger('off.switch');
        }
      });
      $('#switch-btn-1').on('on.switch', function () {
        $('#block-1').addClass('bl-hide');
        $('#block-2').removeClass('bl-hide');
      });
      $('.switch-btn').on('off.switch', function () {
        $('#block-1').removeClass('bl-hide');
        $('#block-2').addClass('bl-hide');
      });
    });
