package service;

import dao.ResultDao;
import model.Result;

public class ResultService {
    private ResultDao resultDao = new ResultDao();

    public void saveQuizResult(Result result) {
        resultDao.saveResult(result);
    }
}
