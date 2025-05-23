const slides = Array.from(document.querySelectorAll('.quiz-slide'));
        let current = 0;

        function updateSlides() {
            slides.forEach((slide, idx) => {
                slide.classList.remove('selected', 'left', 'right');
                if (idx === current) {
                    slide.classList.add('selected');
                } else if (idx === current - 1) {
                    slide.classList.add('left');
                } else if (idx === current + 1) {
                    slide.classList.add('right');
                }
            });
        }

        document.getElementById('arrow-left').onclick = function() {
            current = (current - 1 + slides.length) % slides.length;
            updateSlides();
        };
        document.getElementById('arrow-right').onclick = function() {
            current = (current + 1) % slides.length;
            updateSlides();
        };

        updateSlides();