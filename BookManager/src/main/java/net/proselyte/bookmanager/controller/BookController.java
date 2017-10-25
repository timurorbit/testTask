package net.proselyte.bookmanager.controller;

import net.proselyte.bookmanager.model.Book;
import net.proselyte.bookmanager.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class BookController {
    private BookService bookService;
    private static final int MAX_ROWS_PER_PAGE = 10;

    @Autowired(required = true)
    @Qualifier(value = "bookService")
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }







    @RequestMapping(value = "/books/add", method = RequestMethod.POST)
    public String addBook(@ModelAttribute("book") Book book){
        if(book.getId() == 0){
            this.bookService.addBook(book);
        }else {
            this.bookService.updateBook(book);
        }

        return "redirect:/books";
    }

    @RequestMapping("/remove/{id}")
    public String removeBook(@PathVariable("id") int id){
        this.bookService.removeBook(id);

        return "redirect:/books";
    }

    @RequestMapping("/edit/{id}")
    public String editBook(@PathVariable("id") int id, Model model){
        model.addAttribute("book", this.bookService.getBookById(id));

        return "books";
    }

    @RequestMapping("bookdata/{id}")
    public String bookData(@PathVariable("id") int id, Model model){
        model.addAttribute("book", this.bookService.getBookById(id));

        return "bookdata";
    }

    @RequestMapping("isRead/{id}")
    public String BookIsRead(@PathVariable("id") int id,Model model){
        model.addAttribute("book",this.bookService.getBookById(id));
        this.bookService.BookIsRead(id);
        model.addAttribute("listBooks",this.bookService.listBooks());

        return "redirect:/books";
    }

    @RequestMapping(value = "searchUser" , method = RequestMethod.GET)
    public String searchUser(@RequestParam("searchName") String searchName,Model model){
        model.addAttribute("book",new Book());
        model.addAttribute("userList", this.bookService.listBooks(searchName));
        return "books";
    }

    @RequestMapping(value = "books", method = RequestMethod.GET)
    public String listOfUsers(@RequestParam(required = false) Integer page,Model model) {

        model.addAttribute("book", new Book());

        List<Book> users = bookService.listBooks();
        PagedListHolder<Book> pagedListHolder = new PagedListHolder<Book>(users);
        pagedListHolder.setPageSize(MAX_ROWS_PER_PAGE);

        model.addAttribute("maxPages", pagedListHolder.getPageCount());

        if(page == null || page < 1 || page > pagedListHolder.getPageCount()){
            page=1;
        }
        model.addAttribute("page", page);
        if(page == null || page < 1 || page > pagedListHolder.getPageCount()){
            pagedListHolder.setPage(0);
            model.addAttribute("listBooks", pagedListHolder.getPageList());
        }
        else if(page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page-1);
            model.addAttribute("listBooks", pagedListHolder.getPageList());
        }
        return "books";
    }

    @RequestMapping(value="/list", method=RequestMethod.GET)
    public ModelAndView userListPage(@RequestParam(required = false) Integer page) {
        ModelAndView mav = new ModelAndView("list");

        List<Book> userList = bookService.listBooks();

        PagedListHolder<Book> pagedListHolder = new PagedListHolder<Book>(userList);
        pagedListHolder.setPageSize(10);
        int numberOfPages = pagedListHolder.getPageCount();
        mav.addObject("maxPages",numberOfPages );

        if(page==null || page < 1 || page > pagedListHolder.getPageCount())page=1;

        mav.addObject("page", page);
        if(page == null || page < 1 || page > pagedListHolder.getPageCount()){
            pagedListHolder.setPage(0);
            userList = pagedListHolder.getPageList();
            mav.addObject("userList", userList);
        }
        else if(page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page-1);
            userList = pagedListHolder.getPageList();
            mav.addObject("userList", userList);

        }


        return mav;
    }

}
