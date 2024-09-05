document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('searchForm');
    const booksTableBody = document.querySelector('#booksTable tbody');

    form.addEventListener('submit', (event) => {
        event.preventDefault();
        const title = document.getElementById('searchTitle').value;

        // Clear the table before adding new entries
        booksTableBody.innerHTML = '';

        // For demonstration purposes, use static data. In a real application, fetch data from a server.
        const books = [
            { title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', isbn: '9780743273565', publicationYear: 1925, genre: 'Classic', availableCopies: 5 },
            { title: 'To Kill a Mockingbird', author: 'Harper Lee', isbn: '9780060935467', publicationYear: 1960, genre: 'Fiction', availableCopies: 3 },
            { title: '1984', author: 'George Orwell', isbn: '9780451524935', publicationYear: 1949, genre: 'Dystopian', availableCopies: 4 },
            { title: 'Pride and Prejudice', author: 'Jane Austen', isbn: '9780141439518', publicationYear: 1813, genre: 'Romance', availableCopies: 6 },
            { title: 'The Catcher in the Rye', author: 'J.D. Salinger', isbn: '9780316769488', publicationYear: 1951, genre: 'Literary Fiction', availableCopies: 2 }
        ];

        // Filter books based on the search title
        const filteredBooks = books.filter(book => book.title.toLowerCase().includes(title.toLowerCase()));

        // Populate the table with filtered books
        filteredBooks.forEach(book => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${book.title}</td>
                <td>${book.author}</td>
                <td>${book.isbn}</td>
                <td>${book.publicationYear}</td>
                <td>${book.genre}</td>
                <td>${book.CopiesAvailable}</td>
            `;
            booksTableBody.appendChild(row);
        });
    });
});
