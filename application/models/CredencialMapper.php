<?php

class Application_Model_CredencialMapper {

    protected $_dbTable;

    public function setDbTable($dbTable) {
        if (is_string($dbTable)) {
            $dbTable = new $dbTable();
        }
        if (!$dbTable instanceof Zend_Db_Table_Abstract) {
            throw new Exception('Domínio de dados da tabela fornecida inválido');
        }
        $this->_dbTable = $dbTable;
        return $this;
    }

    public function getDbTable() {
        if (null === $this->_dbTable) {
            $this->setDbTable('Application_Model_DbTable_Credencial');
        }
        return $this->_dbTable;
    }

    public function save(Application_Model_Credencial $credencial) {
        $data = array(
            'perfilAdministrador' => $credencial->getPerfilAdministrador(),
            'perfilPadrao' => $credencial->getPerfilPadrao(),
            'situacao' => $credencial->getSituacao(),
            'funcionario' => $credencial->getFuncionario(),
            'senha' => $credencial->getSenha(),
            'usuario' => $credencial->getUsuario(),
        );

        if (null === ($id = $credencial->getId())) {
            unset($data['id']);
            $this->getDbTable()->insert($data);
        } else {
            $this->getDbTable()->update($data, array('id = ?' => $id));
        }
    }

    public function find($id, Application_Model_Credencial $credencial) {
        $resultado = $this->getDbTable()->find($id);
        if (0 == count($resultado)) {
            return;
        }
        $tupla = $resultado->current();
        $credencial->setId($tupla->id)
                ->setPerfilAdministrador($tupla->perfilAdministrador)
                ->setPerfilPadrao($tupla->perfilPadrao)
                ->setSituacao($tupla->situacao)
                ->setFuncionario($tupla->funcionario)
                ->setSenha($tupla->senha)
                ->setUsuario($tupla->usuario);
    }

    public function fetchAll() {
        $conjuntoDeResultados = $this->getDbTable()->fetchAll();
        $entradas = array();
        foreach ($conjuntoDeResultados as $tupla) {
            $entrada = new Application_Model_Credencial();
            $entrada->setId($tupla->id)
                    ->setPerfilAdministrador($tupla->perfilAdministrador)
                    ->setPerfilPadrao($tupla->perfilPadrao)
                    ->setSituacao($tupla->situacao)
                    ->setFuncionario($tupla->funcionario)
                    ->setSenha($tupla->senha)
                    ->setUsuario($tupla->usuario);
            $entradas[] = $entrada;
        }
        return $entradas;
    }

}
