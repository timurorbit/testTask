DROP DATABASE IF EXISTS test;

CREATE DATABASE test;

USE test;

CREATE TABLE `test`
(
  `id` INT(8) NOT NULL AUTO_INCREMENT,
  `BOOK_TITLE` VARCHAR(100) NOT NULL DEFAULT '0',
  `BOOK_AUTHOR` VARCHAR(100) ,
  `isbn` VARCHAR(20) ,
  `printYear` INT(4),
  `readAlready` BOOL DEFAULT '0',
  `description` VARCHAR(255),
  PRIMARY KEY (`id`)
)
  DEFAULT CHARACTER SET = utf8;

INSERT INTO `test` (`id`,`BOOK_TITLE`,`BOOK_AUTHOR`,`isbn`,`printYear`,`readAlready`,`description`) VALUES (1,"onebook","anyAuthor","1234","1997","0","someDescription"),(2,"twobook","anyAuthor","1234","1997","0","someDescription"),(3,"threebook","anyAuthor","1234","1997","0","someDescription"),(4,"fourbook","anyAuthor","1234","1997","0","someDescription"),(5,"fivebook","anyAuthor","1234","1997","0","someDescription"),(6,"sixbook","anyAuthor","1234","1997","0","someDescription"),(7,"sevenbook","anyAuthor","1234","1997","0","someDescription"),(8,"eightbook","anyAuthor","1234","1997","0","someDescription"),(9,"ninebook","anyAuthor","1234","1997","0","someDescription"),(10,"tenbook","anyAuthor","1234","1997","0","someDescription"),(11,"elevenbook","anyAuthor","1234","1997","0","someDescription"),(12,"twelvebook","anyAuthor","1234","1997","0","someDescription"),(13,"thirteenbook","anyAuthor","1234","1997","0","someDescription"),(14,"fourteenbook","anyAuthor","1234","1997","0","someDescription"),(15,"fifteenbook","anyAuthor","1234","1997","0","someDescription"),(16,"sixteenbook","anyAuthor","1234","1997","0","someDescription"),(17,"seventeenbook","anyAuthor","1234","1997","0","someDescription"),(18,"eighteenbook","anyAuthor","1234","1997","0","someDescription"),(19,"nineteenbook","anyAuthor","1234","1997","0","someDescription"),(20,"twelvebook","anyAuthor","1234","1997","0","someDescription"),(21,"twentyonebook","anyAuthor","1234","1997","0","someDescription"),(22,"twentytwobook","anyAuthor","1234","1997","0","someDescription"),(23,"twentythreebook","anyAuthor","1234","1997","0","someDescription"),(24,"twentyfourbook","anyAuthor","1234","1997","0","someDescription"),(25,"twentyfivetestbook","anyAuthor","1234","1997","0","someDescription")
