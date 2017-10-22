package net.proselyte.bookmanager.dao;

import net.proselyte.bookmanager.model.Book;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Repository
public class BookDaoImpl implements BookDao {
    private static final Logger logger = LoggerFactory.getLogger(BookDaoImpl.class);

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void addBook(Book book) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(book);
        logger.info("Book successfully saved. Book details: " + book);
    }

    @Override
    public void updateBook(Book book) {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(book);
        logger.info("Book successfully update. Book details: " + book);
    }

    @Override
    public void removeBook(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        Book book = (Book) session.load(Book.class, new Integer(id));

        if(book!=null){
            session.delete(book);
        }
        logger.info("Book successfully removed. Book details: " + book);
    }

    @Override
    public Book getBookById(int id) {
        Session session =this.sessionFactory.getCurrentSession();
        Book book = (Book) session.load(Book.class, new Integer(id));
        logger.info("Book successfully loaded. Book details: " + book);

        return book;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Book> listBooks() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Book> bookList = session.createQuery("from Book").list();

        for(Book book: bookList){

            logger.info("Book list: " + book);
        }

        return bookList;
    }

    @Override
    public void BookIsRead(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        Book book = (Book) session.load(Book.class,new Integer(id));
        book.IsRead();
        session.update(book);
        logger.info("Book is successfully read"+book);
    }


    @Override
    public List<Book> listBooks(String name) {
        Session session = this.sessionFactory.getCurrentSession();
        List<Book> userObjects = session.createQuery("from Book").list();
        logger.info("Searching the User. User Names: "+name);
        List<Book> users = new ArrayList<Book>();
        for(Book book: userObjects) {
            if (book.getBookTitle().contains(name)){

            Book user = new Book();
            int id = book.getId();
            String Title = book.getBookTitle();
            String Author = book.getBookAuthor();
            String isbn = book.getIsbn();
            boolean ReadAlready = book.isReadAlready();
            int PrintYear = book.getPrintYear();
            String description = book.getDescription();
            user.setId(id);
            user.setBookTitle(Title);
            user.setBookAuthor(Author);
            user.setIsbn(isbn);
            user.setPrintYear(PrintYear);
            user.setReadAlready(ReadAlready);
            user.setDescription(description);
            users.add(user);

            }
        }
        System.out.println(users);
        return users;


    }


}
