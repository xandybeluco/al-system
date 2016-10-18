<?php

class Application_Model_Credencial {

    protected $_id;
    protected $_perfilAdministrador;
    protected $_perfilPadrao;
    protected $_situacao;
    protected $_funcionario;
    protected $_senha;
    protected $_usuario;

    public function __construct(array $opcoes = null) {
        if (is_array($opcoes)) {
            $this->setOpcoes($opcoes);
        }
    }

    public function __set($nome, $valor) {
        $metodo = 'set' . $nome;
        if (('mapper' == $nome) || !method_exists($this, $metodo)) {
            throw new Exception('Propriedade de credencial inválida');
        }
        $this->$metodo($valor);
    }

    public function __get($nome) {
        $metodo = 'get' . $nome;
        if (('mapper' == $nome) || !method_exists($this, $metodo)) {
            throw new Exception('Propriedade de credencial inválida');
        }
        return $this->$metodo();
    }

    public function setOpcoes(array $opcoes) {
        $metodos = get_class_methods($this);
        foreach ($opcoes as $chave => $valor) {
            $metodo = 'set' . ucfirst($chave);
            if (in_array($metodo, $metodos)) {
                $this->$metodo($valor);
            }
        }
        return $this;
    }

    public function getId() {
        return $this->_id;
    }

    public function setId($id) {
        $this->_id = (int) $id;
        return $this;
    }

    public function getPerfilAdministrador() {
        return $this->_perfilAdministrador;
    }

    public function setPerfilAdministrador($perfilAdministrador) {
        $this->_perfilAdministrador = (boolean) $perfilAdministrador;
        return $this;
    }

    public function getPerfilPadrao() {
        return $this->_perfilPadrao;
    }

    public function setPerfilPadrao($perfilPadrao) {
        $this->_perfilPadrao = (boolean) $perfilPadrao;
        return $this;
    }

    public function getSituacao() {
        return $this->_situacao;
    }

    public function setSituacao($situacao) {
        $this->_situacao = (int) $situacao;
        return $this;
    }

    public function getFuncionario() {
        return $this->_funcionario;
    }

    public function setFuncionario($funcionario) {
        $this->_funcionario = (int) $funcionario;
        return $this;
    }

    public function getSenha() {
        return $this->_senha;
    }

    public function setSenha($senha) {
        $this->_senha = (string) $senha;
        return $this;
    }

    public function getUsuario() {
        return $this->_usuario;
    }

    public function setUsuario($usuario) {
        $this->_usuario = (string) $usuario;
        return $this;
    }

}
