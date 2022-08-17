
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS questions_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions_likes;

PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);



CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    author_id INTEGER,
    title TEXT NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY(author_id) REFERENCES users(id)
);



CREATE TABLE questions_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL, 
    question_id INTEGER NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id)
);



CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    parent_id INTEGER, 
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY(parent_id) REFERENCES replies(id),
    FOREIGN KEY(user_id) REFERENCES users(id)

);



CREATE TABLE questions_likes (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
users (fname, lname)
VALUES
    ("Wilson", "Chen"),
    ("Ivy", "Liu"),
    ("Tommy", "Kim"),
    ("Adina", "Cooper");

INSERT INTO
questions (author_id, title, body)
VALUES
    ((SELECT id FROM users WHERE fname = "Wilson" AND lname = "Chen"), "age?", "How old are you?"),
    ((SELECT id FROM users WHERE fname = "Ivy" AND lname = "Liu"), "sleep?", "Are you sleepy?"),
    ((SELECT id FROM users WHERE fname = "Tommy" AND lname = "Kim"), "type fast?", "Type fast bro?"),
    ((SELECT id FROM users WHERE fname = "Adina" AND lname = "Cooper"), "hearts?", "Play hearts?");

INSERT INTO questions_follows (user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = "Wilson" AND lname = "Chen"), (SELECT id FROM questions WHERE title = "age?")),
    ((SELECT id FROM users WHERE fname ="Ivy" AND lname = "Liu"), (SELECT id FROM questions WHERE title = "sleep?")),
    ((SELECT id FROM users WHERE fname = "Tommy" AND lname = "Kim"), (SELECT id FROM questions WHERE title = "type fast?")),
    ((SELECT id FROM users WHERE fname = "Adina" AND lname = "Cooper"), (SELECT id FROM questions WHERE title = "hearts?"));

INSERT INTO replies (parent_id, question_id, user_id, body)
VALUES
    ( NULL, (SELECT id FROM questions WHERE title = "age?"), (SELECT id FROM users WHERE fname = "Wilson" AND lname = "Chen"), "28" ),
    ( (SELECT id FROM replies WHERE body = "28"), (SELECT id FROM questions WHERE title = "sleep?"), (SELECT id FROM users WHERE fname = "Ivy" AND lname = "Liu"), "Yes"),
    ( NULL, (SELECT id FROM questions WHERE title = "type fast?"), (SELECT id FROM users WHERE fname = "Tommy" AND lname = "Kim"), "No"),
    ( (SELECT id FROM replies WHERE body = "No"), (SELECT id FROM questions WHERE title = "hearts?"), (SELECT id FROM users WHERE fname = "Adina" AND lname = "Cooper"), "you suck");


INSERT INTO questions_likes (question_id, user_id)
VALUES
    ((SELECT id FROM questions WHERE title = "age?"), (SELECT id FROM users WHERE fname = "Wilson" AND lname = "Chen")),
    ((SELECT id FROM questions WHERE title = "sleep?"), (SELECT id FROM users WHERE fname ="Ivy" AND lname = "Liu")),
    ((SELECT id FROM questions WHERE title = "type fast?"), (SELECT id FROM users WHERE fname = "Tommy" AND lname = "Kim")),
    ((SELECT id FROM questions WHERE title = "hearts?"), (SELECT id FROM users WHERE fname = "Adina" AND lname = "Cooper"));

