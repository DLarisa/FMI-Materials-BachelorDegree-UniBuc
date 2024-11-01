package pao.unibuc.demo;

import javax.swing.*;
import java.awt.*;

import static pao.unibuc.demo.MyFrame.NEW_NOTE;

public class MyPanel extends JPanel {
    private JTextField titleTextField;
    private MyNote note;
    private JTextPane contentTextPane;

    public MyPanel(){
        GridBagLayout gridBagLayout = new GridBagLayout();
        gridBagLayout.columnWidths = new int[]{0, 0, 0};
        gridBagLayout.rowHeights =new int[]{0, 0, 0};
        gridBagLayout.columnWeights = new double[]{0, 1, 0};
        gridBagLayout.rowWeights = new double[]{0,1, 0};
        setLayout(gridBagLayout);

        JLabel titleLabel =  new JLabel("Title");
        GridBagConstraints gridBagConstraints = new GridBagConstraints();
        gridBagConstraints.anchor = GridBagConstraints.EAST;
        gridBagConstraints.insets = new Insets(0, 0, 5, 5);
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        add(titleLabel, gridBagConstraints);

        titleTextField = new JTextField();
        gridBagConstraints = new GridBagConstraints();
        gridBagConstraints.insets = new Insets(0, 0, 5, 0);
        gridBagConstraints.fill = GridBagConstraints.HORIZONTAL;
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        add(titleTextField, gridBagConstraints);
        titleTextField.setColumns(10);

        JLabel contentLabel = new JLabel("Content");
        gridBagConstraints = new GridBagConstraints();
        gridBagConstraints.anchor = GridBagConstraints.NORTH;
        gridBagConstraints.insets = new Insets(0, 0, 0, 5);
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        add(contentLabel, gridBagConstraints);

        contentTextPane = new JTextPane();
        gridBagConstraints = new GridBagConstraints();
        gridBagConstraints.fill = GridBagConstraints.BOTH;
        gridBagConstraints.insets = new Insets(0, 0, 0, 5);
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 1;
        add(contentTextPane, gridBagConstraints);
    }

    public void setNote(MyNote note){
        this.note = note;
        titleTextField.setText(note.getTitle().equalsIgnoreCase(NEW_NOTE) ? "" : note.getTitle());
        contentTextPane.setText(note.getContent());
        titleTextField.requestFocus();
    }

    public MyNote getNote(){
        return note.title(titleTextField.getText()).content(contentTextPane.getText());
    }

    public void clear(){
        note.title(NEW_NOTE).content("");
        titleTextField.setText("");
        contentTextPane.setText("");
    }
}
