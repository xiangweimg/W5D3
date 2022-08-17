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
    FOREIGN KEY(question_id) REFERENCES questions(parent_id)
);

CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    parent_id INTEGER, 
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    body TEXT NOT NULL,
    FOREIGN KEY(parent_id) REFERENCES replies(id),
    FOREIGN KEY(user_id) REFERENCES users(id)

);

CREATE TABLE questions_likes(
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(parent_id)
);

