document.addEventListener("turbolinks:load", () => {
    $('form').on('keydown', 'input, button, select', function(e) {
        if (e.key === 'Enter') {
            if ($(this).attr("type") === 'submit') return;

            const form = $(this).closest('form');
            const focusable = form.find('input, button[type="submit"], select, textarea')
                .not('[readonly]').filter(':visible');

            if (e.shiftKey) {
                focusable.eq(focusable.index(this) - 1).trigger("focus");
            } else {
                const next = focusable.eq(focusable.index(this) + 1);
                if (next.length) {
                    next.trigger("focus");
                } else {
                    focusable.eq(0).trigger("focus");
                }
            }

            e.preventDefault();
        }
    });
})
