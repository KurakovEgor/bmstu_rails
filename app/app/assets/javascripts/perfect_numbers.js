function showResult(data) {
    if (!data || data.error !== null) {
        resetData();
        let error = 'Internal Error';
        if (data) {
            error = data.error;
        }
        $('span.error').text(error);
        return;
    }

    const result = $('div.result');

    let html = `
    <h1>Результаты:</h1>
    <p>
        <i>Самая длинная последовательность совершенных чисел:</i>
        ${(data.longest_seq || ['Не нашлось самой длинной последовательности']).join(', ')}
    </p>
    <p>
        Последовательности совершенных чисел:
        <table>
            <thead>
                <tr>
                    <th>№</th>
                    <th>Последовательность</th>
                </tr>
            </thead>
            <tbody>
    `;

    data.sequences.forEach((seq, i) => {
        html += `
        <tr>
            <td>${i+1}</td>
            <td>${seq.join(', ')}</td>
        </tr>
        `;
    });

    if (data.sequences.length === 0) {
        html += `
        <tr>
            <td>Не нашлось ни одной последовательности</td>
        </tr>
        `;
    }

    html += `</tbody></table></p>`;
    result.append(html);
}

function listInputs(event) {
    event.preventDefault();

    const n = $('#n').val();
    const form = $('#form');

    resetData();

    if (validateNumber(n) === '') {
        const data = $('div.data');
        form.data({n: n});
        form.removeClass('hidden');

        for(let i = 0; i < n; i++) {
            data.append(
                `<p>
                    <label for="A${i}">A${i}: </label>
                    <input class="A${i}" name="input_numbers[${i}]" type="number">
                </p>`
            );
        }
    } else {
        $('#input_n input[type="submit"]').removeProp('disabled');
    }
}

function validateNumber(n) {
    let error = '';

    if (!isFinite(n) || isNaN(parseFloat(n))) {
        error = 'Введите число!';
    } else if (parseInt(n) !== parseFloat(n) || parseInt(n) <= 0) {
        error = 'Введите положительное целое число!';
    } else if (parseInt(n) > 100) {
        error = 'Слишком большое число!';
    }

    $('span.error').text(error);
    return error;
}

function validateData(event) {
    let success = true;

    const inputs = $('div.data p input[type="number"]');
    inputs.each((i, el) => {
        const val = $(el).val();
        const error = validateNumber(val);
        $(el).removeClass('redBorder');
        if (error !== '') {
            $(el).empty();
            $(el).addClass('redBorder');
            success = false;
        }
        $('span.error').text('');
    });

    return success && inputs.length > 0;
}

function resetData() {
    const form = $('#form');
    form.data({n: 0});
    form.addClass('hidden');
    $('div.data').empty();
    $('div.result').empty();
    $('span.error').empty();
    $('#input_n input[type="submit"]').removeProp('disabled');
}

$(document).ready(() => {
    $('#input_n').submit(listInputs);
    $('button[type="reset"]').click(resetData);
    const submit = $('#form');
    submit.submit(validateData);
    submit.bind('ajax:success', (xrs, data, status) => {
        resetData();
        showResult(xrs.detail[0]);
    });
});