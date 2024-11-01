package pao.unibuc.demo;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import java.awt.*;

public class MyFrame extends JFrame {
    public static final String NEW_NOTE = "<New note>";
    public MyFrame(MyContract proxy){
        setTitle("Notes");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setBounds(100, 100, 700, 400);
        JPanel contentPane = new JPanel();
        contentPane.setBorder(new EmptyBorder(5,5,5,5));
        contentPane.setLayout(new BorderLayout(0, 0));
        setContentPane(contentPane);
        JSplitPane splitPane = new JSplitPane();
        splitPane.setResizeWeight(0.3);
        contentPane.add(splitPane, BorderLayout.CENTER);
        final DefaultListModel<MyNote> notes = new DefaultListModel<MyNote>();
        JList<MyNote> list = new JList<>(notes);
        splitPane.setLeftComponent(list);
        JPanel panel = new JPanel();
        splitPane.setRightComponent(panel);

        GridBagLayout gridBagLayout = new GridBagLayout();
        gridBagLayout.columnWeights = new double[]{1, 0};
        gridBagLayout.columnWidths = new int[]{0, 0};
        gridBagLayout.rowHeights = new int[]{0, 0, 0};
        gridBagLayout.rowWeights = new double[]{1, 0, 0};
        panel.setLayout(gridBagLayout);

        final MyPanel notePanel = new MyPanel();
        GridBagConstraints gridBagConstraints = new GridBagConstraints();
        gridBagConstraints.insets = new Insets(0, 0, 5, 0);
        gridBagConstraints.fill = GridBagConstraints.BOTH;
        gridBagConstraints.gridx = 0 ;
        gridBagConstraints.gridy =0;
        panel.add(notePanel, gridBagConstraints);

        JPanel buttonsPanel  = new JPanel();
        gridBagConstraints = new GridBagConstraints();
        gridBagConstraints.fill = GridBagConstraints.BOTH;
        gridBagConstraints.gridx = 0 ;
        gridBagConstraints.gridy = 1;
        panel.add(buttonsPanel, gridBagConstraints);

        JButton createButton = new JButton("Create");
        createButton.addActionListener(event -> {
            MyNote note = notePanel.getNote();
            if(!note.getTitle().isEmpty() && !note.getContent().isEmpty()){
                try {
                    note = proxy.createNote(note.getTitle(), note.getContent());
                    notes.addElement(note);
                    notePanel.clear();
                    list.setSelectedIndex(notes.size()-1);
                } catch (Exception e) {
                    JOptionPane.showMessageDialog(MyFrame.this, e.getLocalizedMessage(), "Error", JOptionPane.ERROR_MESSAGE);
                }
            }
        });
        buttonsPanel.add(createButton);
        createButton.setVisible(false);

        JButton updateButton = new JButton("Update");
        updateButton.addActionListener(event ->{
            MyNote note = notePanel.getNote();
            if(!note.getTitle().isEmpty() && !note.getContent().isEmpty()){
                try {
                    if(proxy.updateNote(note)){
                        notes.set(list.getSelectedIndex(), note);
                    }
                } catch (Exception e) {
                    JOptionPane.showMessageDialog(MyFrame.this, e.getLocalizedMessage(), "Error", JOptionPane.ERROR_MESSAGE);
                }
            }
        });
        buttonsPanel.add(updateButton);
        updateButton.setVisible(false);

        JButton deleteButton = new JButton("Delete");
        deleteButton.addActionListener(event -> {
            try {
                if(proxy.deleteNote(notePanel.getNote().getId())){
                    int index = list.getSelectedIndex();
                    list.setSelectedIndex(0);
                    notes.remove(index);
                }
            } catch (Exception e) {
                JOptionPane.showMessageDialog(MyFrame.this, e.getLocalizedMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            }
        });
        buttonsPanel.add(deleteButton);
        deleteButton.setVisible(false);

        notes.addElement(new MyNote().title(NEW_NOTE));
        list.addListSelectionListener(event -> {
            MyNote note = ((JList<MyNote>)event.getSource()).getSelectedValue();
            notePanel.setNote(note);
            createButton.setVisible(NEW_NOTE.equals(note.getTitle()));
            updateButton.setVisible(!NEW_NOTE.equals(note.getTitle()));
            deleteButton.setVisible(!NEW_NOTE.equals(note.getTitle()));
        });

        try {
            proxy.readNotes().forEach(note -> notes.addElement(note));
        } catch (Exception e) {
            JOptionPane.showMessageDialog(MyFrame.this, e.getLocalizedMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
}
