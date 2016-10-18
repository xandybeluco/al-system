<?php

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap {

    protected function _initAutoload() {
        $autoload = new Zend_Application_Module_Autoloader(array(
            'basePath' => APPLICATION_PATH,
            'namespace' => 'Application'
        ));
        return $autoload;
    }

    protected function _initDoctype() {
        $this->bootstrap('view');
        $view = $this->getResource('view');
        $view->doctype('XHTML1_STRICT');
    }

}
