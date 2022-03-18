<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Welcome extends CI_Controller {
	public function __construct(){
		parent::__construct();
        $this->load->database('login');
		$this->load->model('ModLogin');
	}

	
	public function index()
	{
		$this->load->view('Template/head');
		$this->load->view('login');
		$this->load->view('Template/footer');
	}
	public function register(){
		$this->load->view('Template/head');
		$this->load->view('register');
		$this->load->view('Template/footer');
	}
	public function forgotPsw(){
		$this->load->view('Template/head');
		$this->load->view('forgot');
		$this->load->view('Template/footer');
	}
	public function log_in(){
		$usr = $_POST['user'];
		$psw = $_POST['password'];
		$data = $this->ModLogin->log_in($usr,$psw); 
		if ($data['msg'] == "Activo") {
			echo '<script >alert("Usuario '.$data['msg'].'");</script>';
			if($data['user'] != false){
				$sessionUsr = array(
				'txtNombreCompleto'=> $data['user']['txtNombreCompleto'],
				'nombre'=> $data['user']['nombre'],
				'apellidos'=> $data['user']['apellidos'],
				'telefono'=> $data['user']['telefono'],
				'mail'=> $data['user']['mail'],
				'nickName'=> $data['user']['nickName'],
				'userType'=> $data['user']['userType'],
				'nIdTipoP'=> $data['user']['nIdTipoP'],
				'dateLog' => getdate()
			);
				$this->session->set_userdata($sessionUsr);
				if($data['user']['nIdTipoP'] == 1) $this->admin();
				if($data['user']['nIdTipoP'] == 2) $this->docente();
				if($data['user']['nIdTipoP'] == 3) $this->alumno();
			}
		}else{
			echo '<script >alert("Usuario '.$data['msg'].'");</script>';
			$this->index();
		}
		
	}
	public function base(){
		$info['allUsers'] = $this->ModLogin->allUsers(); 
		$this->load->view('Template/head');
		$this->load->view('usuarios',$info);
		$this->load->view('Template/footer');
	}
	public function admin(){
		$this->load->view('Template/head');
		$this->load->view('admin/dashboard');
		$this->load->view('Template/menu');
		
		$this->load->view('Template/footer');
	}

	public function docente(){
		$this->load->view('Template/head');
		$this->load->view('docente/dashboard');
		$this->load->view('Template/menu');
		$this->load->view('Template/footer');
	}
	public function alumno(){
		$this->load->view('alumno/dashboard');
		$this->load->view('Template/head');
		$this->load->view('Template/menu');
		$this->load->view('Template/footer');
	}
}
