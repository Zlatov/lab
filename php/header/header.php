<?php
header('Content-Type: text/html; charset=utf-8');
// header('Content-Type: text/plain');
// header('Content-Type: application/json');

// http_response_code(418); // Приводит к 500, проще `header(...`:
header("HTTP/1.0 418 I’m a teapot");

echo "Русский Ёж";
