CREATE TABLE sample_user (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50)
);

INSERT INTO sample_user(username) VALUES ('mkaleda');
INSERT INTO sample_user(username) VALUES ('mkaleda@exadel.com');
INSERT INTO sample_user(username) VALUES ('insolenset');