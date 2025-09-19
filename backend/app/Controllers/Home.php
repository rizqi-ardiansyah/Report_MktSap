<?php

namespace App\Controllers;
use CodeIgniter\Controller;
use Config\Database;

class Home extends BaseController
{
    public function index(): string
    {
        return view('welcome_message');
    }
}
