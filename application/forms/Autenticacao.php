<?php

class Application_Form_Autenticacao extends Zend_Form {

    public function init() {
        $this->setMethod('post');

        $usuario = new Zend_Form_Element_Text('usuario');
        $usuario->setLabel('Usuário')
                ->setRequired(TRUE)
                ->addFilter(new Zend_Filter_StringTrim())
                ->addFilter(new Zend_Filter_StripTags())
                ->addValidator(new Zend_Validate_NotEmpty())
                ->addValidator(new Zend_Validate_StringLength(2, 16));

        $senha = new Zend_Form_Element_Password('senha');
        $senha->setLabel('Senha')
                ->setRequired(TRUE)
                ->addFilter(new Zend_Filter_StringTrim())
                ->addFilter(new Zend_Filter_StripTags())
                ->addValidator(new Zend_Validate_NotEmpty());

        $autenticar = new Zend_Form_Element_Submit('autenticar');
        $autenticar->setLabel('Autenticar');

        $this->addElements(array(
            $usuario,
            $senha,
            $autenticar
        ));
    }

}
