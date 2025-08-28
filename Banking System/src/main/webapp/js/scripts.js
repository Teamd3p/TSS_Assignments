document.addEventListener('DOMContentLoaded', () => {
    // Real-time form validation for numeric inputs
    const numericInputs = document.querySelectorAll('input[pattern="^[0-9]+$"]');
    numericInputs.forEach(input => {
        input.addEventListener('input', () => {
            if (input.validity.patternMismatch) {
                input.classList.add('is-invalid');
            } else {
                input.classList.remove('is-invalid');
            }
        });
    });

    // Real-time amount validation
    const amountInputs = document.querySelectorAll('input[type="number"][min="0.01"]');
    amountInputs.forEach(input => {
        input.addEventListener('input', () => {
            if (input.value <= 0) {
                input.classList.add('is-invalid');
            } else {
                input.classList.remove('is-invalid');
            }
        });
    });

    // Real-time phone validation
    const phoneInputs = document.querySelectorAll('input[pattern="^[0-9\\-+()\\s]{8,15}$"]');
    phoneInputs.forEach(input => {
        input.addEventListener('input', () => {
            if (input.validity.patternMismatch) {
                input.classList.add('is-invalid');
            } else {
                input.classList.remove('is-invalid');
            }
        });
    });

    // Real-time Aadhar validation
    const aadharInputs = document.querySelectorAll('input[pattern="^[0-9]{12}$"]');
    aadharInputs.forEach(input => {
        input.addEventListener('input', () => {
            if (input.validity.patternMismatch) {
                input.classList.add('is-invalid');
            } else {
                input.classList.remove('is-invalid');
            }
        });
    });

    // Real-time PAN validation
    const panInputs = document.querySelectorAll('input[pattern="^[A-Z]{5}[0-9]{4}[A-Z]{1}$"]');
    panInputs.forEach(input => {
        input.addEventListener('input', () => {
            if (input.validity.patternMismatch) {
                input.classList.add('is-invalid');
            } else {
                input.classList.remove('is-invalid');
            }
        });
    });
});