$(document).on("turbolinks:load", function(){
    $('.dropdown-menu').parent().on('show.bs.dropdown', function () {
        var parentResponsiveTable = $(this).parents('.table-responsive');
        var parentTarget = $(parentResponsiveTable).first().hasClass('table-responsive') ? $(parentResponsiveTable) : $(window);
        var parentTop = $(parentResponsiveTable).first().hasClass('table-responsive') ? $(parentResponsiveTable).offset().top : 0;
        var parentLeft = $(parentResponsiveTable).first().hasClass('table-responsive') ? $(parentResponsiveTable).offset().left : 0;

        var dropdownMenu = $(this).children('.dropdown-menu').first();

        if (!$(this).hasClass('dropdown') && !$(this).hasClass('dropup')) {
            $(this).addClass('dropdown');
        }
        $(this).attr('olddrop', $(this).hasClass('dropup') ? 'dropup' : 'dropdown');
        $(this).children('.dropdown-menu').each(function () {
            $(this).attr('olddrop-pull', $(this).hasClass('dropdown-menu-right') ? 'dropdown-menu-right' : '');
        });

        if ($(this).hasClass('dropdown')) {
            if ($(this).offset().top + $(this).height() + $(dropdownMenu).height() + 10 >= parentTop + $(parentTarget).height()) {
                $(this).removeClass('dropdown');
                $(this).addClass('dropup');
            }
        } else if ($(this).hasClass('dropup')) {
            if ($(this).offset().top - $(dropdownMenu).height() - 10 <= parentTop) {
                $(this).removeClass('dropup');
                $(this).addClass('dropdown');
            }
        }

        if ($(this).offset().left + $(dropdownMenu).width() >= parentLeft + $(parentTarget).width()) {
            $(this).children('.dropdown-menu').addClass('dropdown-menu-right');
        }
    });

    $('.dropdown-menu').parent().on('hide.bs.dropdown', function () {
        if ($(this).attr('olddrop') != '') {
            $(this).removeClass('dropup dropdown');
            $(this).addClass($(this).attr('olddrop'));
            $(this).attr('olddrop', '');
        }

        $(this).children('.dropdown-menu').each(function () {
            $(this).removeClass('dropdown-menu-right');
            $(this).addClass($(this).attr('olddrop-pull'));
        });
    });
});
