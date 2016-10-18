<?php

class IndexController extends Zend_Controller_Action {

    public function init() {
        if (!Zend_Auth::getInstance()->hasIdentity()) {
            return $this->_helper->redirector->goToRoute(array(
                'controller' => 'autenticacao'
            ), NULL, TRUE);
        }
    }

    public function indexAction() {
        // action body
    }

}
