<?php

class Application_Form_Autenticacao extends Zend_Form {

    public function init() {
        $this->setMethod('post');
        $usuario = $this->criarTextInputUsuario();
        $senha = $this->criarTextInputSenha();
        $autenticar = $this->criarSubmitAutenticar();
        $this->addElements(array(
            $usuario,
            $senha,
            $autenticar
        ));
    }

    private function criarTextInputUsuario() {
        $usuario = new Zend_Form_Element_Text('usuario');
        return $usuario->setLabel('Usuário')
                        ->setRequired(TRUE)
                        ->addFilter(new Zend_Filter_StringTrim())
                        ->addFilter(new Zend_Filter_StripTags())
                        ->addValidator(new Zend_Validate_NotEmpty())
                        ->addValidator(new Zend_Validate_StringLength(2, 16));
    }

    private function criarTextInputSenha() {
        $senha = new Zend_Form_Element_Password('senha');
        return $senha->setLabel('Senha')
                        ->setRequired(TRUE)
                        ->addFilter(new Zend_Filter_StringTrim())
                        ->addFilter(new Zend_Filter_StripTags())
                        ->addValidator(new Zend_Validate_NotEmpty());
    }

    private function criarSubmitAutenticar() {
        $autenticar = new Zend_Form_Element_Submit('autenticar');
        return $autenticar->setLabel('Autenticar');
    }

}
