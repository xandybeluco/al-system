<?php

class ErrorController extends Zend_Controller_Action {

    public function errorAction() {
        $erros = $this->_getParam('error_handler');

        if (!$erros || !$erros instanceof ArrayObject) {
            $this->view->message = 'Você está na página de erros';
            return;
        }

        switch ($erros->type) {
            case Zend_Controller_Plugin_ErrorHandler::EXCEPTION_NO_ROUTE:
            //
            case Zend_Controller_Plugin_ErrorHandler::EXCEPTION_NO_CONTROLLER:
            //
            case Zend_Controller_Plugin_ErrorHandler::EXCEPTION_NO_ACTION:
                // 404 error -- controller or action not found
                $this->getResponse()->setHttpResponseCode(404);
                $prioridade = Zend_Log::NOTICE;
                $this->view->message = 'Página não encontrada';
                break;
            default:
                // application error
                $this->getResponse()->setHttpResponseCode(500);
                $prioridade = Zend_Log::CRIT;
                $this->view->message = 'Erro interno do servidor';
                break;
        }

        // Log exception, if logger available
        if ($log = $this->getLog()) {
            $log->log($this->view->message, $prioridade, $erros->exception);
            $log->log('Parâmetros da requisição', $prioridade, $erros->request->getParams());
        }

        // conditionally display exceptions
        if ($this->getInvokeArg('displayExceptions') == true) {
            $this->view->exception = $erros->exception;
        }

        $this->view->request = $erros->request;
    }

    public function getLog() {
        $bootstrap = $this->getInvokeArg('bootstrap');
        if (!$bootstrap->hasResource('Log')) {
            return false;
        }
        $log = $bootstrap->getResource('Log');
        return $log;
    }

}
