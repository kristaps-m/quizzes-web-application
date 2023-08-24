document.addEventListener('DOMContentLoaded', function () {
    var questionTypeSelect = document.getElementById('question_question_type');
    var singleAnswerFields = document.querySelector('.form-fields.single-answer');
    var multipleChoiceFields = document.querySelector('.form-fields.multiple-choice');
    var addChoiceButton = document.querySelector('.add-choice-button');
    var form = document.querySelector('form');

    function toggleChoiceButtons() {
        if (questionTypeSelect.value === 'Single Answer') {
            singleAnswerFields.style.display = 'block';
            multipleChoiceFields.style.display = 'none';
        } else if (questionTypeSelect.value === 'Multiple Choice') {
            singleAnswerFields.style.display = 'none';
            multipleChoiceFields.style.display = 'block';
        }
    }

    questionTypeSelect.addEventListener('change', toggleChoiceButtons);

    toggleChoiceButtons();

    addChoiceButton.addEventListener('click', function (event) {
        event.preventDefault();

        var answerFieldset = document.createElement('fieldset');

        var choiceLabel = document.createElement('label');
        choiceLabel.textContent = 'Choice:';

        var choiceInput = document.createElement('input');
        choiceInput.type = 'text';
        choiceInput.name = 'question[answers_attributes][][choice]';
        choiceInput.className = 'form-style';

        var correctLabel = document.createElement('label');
        correctLabel.textContent = 'Correct:';

        var correctCheckbox = document.createElement('input');
        correctCheckbox.type = 'checkbox';
        correctCheckbox.name = 'question[answers_attributes][][correct]';

        answerFieldset.appendChild(choiceLabel);
        answerFieldset.appendChild(choiceInput);
        answerFieldset.appendChild(correctLabel);
        answerFieldset.appendChild(correctCheckbox);

        var removeChoiceButton = document.createElement('a');
        removeChoiceButton.href = '#';
        removeChoiceButton.textContent = 'Remove Choice';
        removeChoiceButton.className = 'remove-choice-button';

        removeChoiceButton.addEventListener('click', function (event) {
            event.preventDefault();
            answerFieldset.remove();
        });

        answerFieldset.appendChild(removeChoiceButton);

        multipleChoiceFields.querySelector('.add-choice-container').insertBefore(answerFieldset, addChoiceButton);
    });

    form.addEventListener('click', function (event) {
        if (event.target.classList.contains('remove-choice-button')) {
            event.preventDefault();
            var choiceFieldset = event.target.closest('fieldset.choice-fields');
            if (choiceFieldset) {
                choiceFieldset.remove();
            }
        }
    });

    questionTypeSelect.dispatchEvent(new Event('change'));
});