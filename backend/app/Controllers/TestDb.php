<?php

namespace App\Controllers;
use CodeIgniter\Controller;
use Config\Database;

class TestDb extends Controller
{
    public function index()
    {
        $db = Database::connect();
        $query = $db->query("SHOW TABLES");
        $result = $query->getResult();
        echo "<pre>";
        print_r($result);
        echo "</pre>";

        // try {
        // $db = Database::connect();
        // echo "✅ Berhasil konek ke database<br>";

        // $query = $db->query("SHOW TABLES");
        // $result = $query->getResult();
        
        // echo "<pre>";
        // print_r($result);
        // echo "</pre>";
        // } catch (\Exception $e) {
        //     echo "❌ Gagal konek DB: " . $e->getMessage();
        // }
        
    }
}
