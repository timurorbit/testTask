<%@ page import="net.proselyte.bookmanager.model.Book" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>



<%@ page session="false" %>
<html>
<head>
    <title>Books Page</title>

    <style type="text/css">
        .tg {
            border-collapse: collapse;
            border-spacing: 0;
            border-color: #ccc;
        }

        .tg td {
            font-family: Arial, sans-serif;
            font-size: 14px;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #fff;
        }

        .tg th {
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: normal;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #f0f0f0;
        }

        .tg .tg-4eph {
            background-color: #f9f9f9
        }
    </style>
</head>
<body>
<a href="../../index.jsp">Back to main menu</a>

<br/>
<br/>

<h1>Book List</h1>

<c:if test="${!empty listBooks}">
    <table class="tg">
        <tr>
            <th width="80">ID</th>
            <th width="120">Title</th>
            <th width="120">Author</th>
            <th width="120">isbn</th>
            <th width = "120">readAlready</th>
            <th width="120">printYear</th>
            <th width="240">description</th>
            <th width="60">Edit</th>
            <th width="60">Delete</th>
            <th width="60">Read?</th>
        </tr>
        <c:forEach items="${listBooks}" var="book">
            <tr>
                <td>${book.id}</td>
                <td><a href="/bookdata/${book.id}" target="_blank">${book.bookTitle}</a></td>
                <td>${book.bookAuthor}</td>
                <td>${book.isbn}</td>
                <td>${book.readAlready}</td>
                <td>${book.printYear}</td>
                <td>${book.description}</td>
                <td><a href="<c:url value='/edit/${book.id}'/>">Edit</a></td>
                <td><a href="<c:url value='/remove/${book.id}'/>">Delete</a></td>
                <td><a href="<c:url value='/isRead/${book.id}'/>">BookIsRead</a></td>
            </tr>
        </c:forEach>
    </table>
</c:if>
<form id="pagination" >
    <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">

        <c:choose>
            <c:when test="${page == i.index}">
                <span>${i.index}</span>
            </c:when>
            <c:otherwise>
                <c:url value="books" var="url">
                    <c:param name="page" value="${i.index}"/>
                </c:url>
                <a href='<c:out value="${url}" />'>${i.index}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</form>

<h1>Find a book by Title </h1>
<form action="/searchUser">
    <div class="row">
        <div class="col-md-2">Search book by title:</div>
        <div class="col-md-2"><input type="text" name="searchName" id="searchName"
                                     placeholder="type title here.."></div>
        <div class="col-md-2"><input class="btn btn-xs" type='submit' value='Search'/></div>
    </div>
</form>
<c:if test="${not empty userList}">

    <<table class="tg">>

    <tr>
        <th width="80">ID</th>
        <th width="120">Title</th>
        <th width="120">Author</th>
        <th width="120">isbn</th>
        <th width = "120">readAlready</th>
        <th width="120">printYear</th>
        <th width="240">description</th>
        <th width="60">Edit</th>
        <th width="60">Delete</th>
        <th width="60">Read?</th>
    </tr>
    <tbody>
    <c:forEach items="${userList}" var="book">
        <tr>
            <td>${book.id}</td>
            <td><a href="/bookdata/${book.id}" target="_blank">${book.bookTitle}</a></td>
            <td>${book.bookAuthor}</td>
            <td>${book.isbn}</td>
            <td>${book.readAlready}</td>
            <td>${book.printYear}</td>
            <td>${book.description}</td>
            <td><a href="<c:url value='/edit/${book.id}'/>">Edit</a></td>
            <td><a href="<c:url value='/remove/${book.id}'/>">Delete</a></td>
            <td><a href="<c:url value='/isRead/${book.id}'/>">BookIsRead</a></td>
        </tr>
    </c:forEach>
    </tbody>
    </table>
</c:if>


<h1>Add/Edit a Book</h1>
<c:set value="${book.bookAuthor}" var="bookauthor" ></c:set>
<c:set value="" var="Myempty" ></c:set>

<c:url var="addAction" value="/books/add"/>



<form:form action="${addAction}" commandName="book">
    <table>
        <c:if test="${!empty book.bookTitle}">
            <tr>
                <td>
                    <form:label path="id">
                        <spring:message text="ID"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="id" readonly="true" size="8" disabled="true"/>
                    <form:hidden path="id"/>
                </td>
            </tr>
        </c:if>
        <tr>
            <td>
                <form:label path="bookTitle">
                    <spring:message text="Title"/>
                </form:label>
            </td>
            <td>
                <form:input path="bookTitle" />
            </td>
        </tr>


        <c:choose>
            <c:when test="${empty bookauthor}">
                <tr>
                    <td>
                        <form:label path="bookAuthor">
                            <spring:message text="Author" />
                        </form:label>
                    </td>
                    <td>

                        <form:input path="bookAuthor" />

                    </td>
                </tr>
            </c:when>
            <c:otherwise>
                <tr>
                    <td>
                        <form:label path="bookAuthor" >
                            <spring:message text="Author" />
                        </form:label>
                    </td>
                    <td>

                        <form:input path="bookAuthor" disabled="true" />
                        <form:hidden path="bookAuthor"/>

                    </td>
                </tr>
            </c:otherwise>
        </c:choose>







        <tr>
            <td>
                <form:label path="isbn">
                    <spring:message text="ISBN"/>
                </form:label>
            </td>
            <td>
                <form:input path="isbn"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="readAlready">
                    <spring:message text="Read Already?"/>
                </form:label>
            </td>
                ${book.readAlready=false}
            <td>
                    <form:input path="readAlready" disabled="true"  />
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="printYear">
                    <spring:message text="Year of publishing?"/>
                </form:label>
            </td>
            <td>
                <form:input path="printYear"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="description">
                    <spring:message text="Description"/>
                </form:label>
            </td>
            <td>
                <form:input path="description"/>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <c:if test="${!empty book.bookTitle}">
                    <input type="submit"
                           value="<spring:message text="Edit Book"/>"/>
                </c:if>
                <c:if test="${empty book.bookTitle}">
                    <input type="submit"
                           value="<spring:message text="Add Book"/>"/>
                </c:if>
            </td>
        </tr>
    </table>
</form:form>


</body>
</html>
